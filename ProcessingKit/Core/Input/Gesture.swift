//
//  Gesture.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2018/10/07.
//  Copyright © 2018 Atsuya Sato. All rights reserved.
//

import Foundation

#if os(iOS)
import UIKit
#elseif os(OSX)
import Cocoa
#endif

public enum GestureEvent {
    #if os(iOS)
    case didTap
    case didRelease
    case didDrag
    case didSwipe(direction: UISwipeGestureRecognizer.Direction)
    case didPinch(scale: CGFloat, velocity: CGFloat)
    case didRotate(rotation: CGFloat, velocity: CGFloat)
    case didLongPress
    #elseif os(OSX)
    case didClick
    case didRelease
    case didDrag
    case didMove
    case didMagnify(magnification: CGFloat)
    case didRotate(rotation: CGFloat, inDegrees: CGFloat)
    case didPress
    case didScroll(x: CGFloat, y: CGFloat)
    #endif
}

public protocol GestureComponentsContract {
    var delegateEvents: [GestureEvent] { get set }
    #if os(iOS)
    var isPressed: Bool { get set }
    var touchX: CGFloat { get set }
    var touchY: CGFloat { get set }
    var touches: Set<CGPoint> { get set }
    #elseif os(OSX)
    var isPressed: Bool { get set }
    var mouseX: CGFloat { get set }
    var mouseY: CGFloat { get set }
    #endif
}

public protocol GestureModelContract {
    #if os(iOS)
    var fingerPressed: Bool { get }
    var touchX: CGFloat { get }
    var touchY: CGFloat { get }
    var touches: Set<CGPoint> { get }

    mutating func didTap(recognizer: UITapGestureRecognizer)
    mutating func didTapExit(recognizer: UITapGestureRecognizer)
    mutating func didPan(recognizer: UIPanGestureRecognizer)

    mutating func didSwipe(recognizer: UISwipeGestureRecognizer)
    mutating func didPinch(recognizer: UIPinchGestureRecognizer)
    mutating func didRotate(recognizer: UIRotationGestureRecognizer)
    mutating func didLongPress(recognizer: UILongPressGestureRecognizer)

    mutating func touchesBegan(_ touches: Set<CGPoint>)
    mutating func touchesMoved(_ touches: Set<CGPoint>)
    mutating func touchesEnded(_ touches: Set<CGPoint>)
    #elseif os(OSX)
    var mousePressed: Bool { get }
    var mouseX: CGFloat { get }
    var mouseY: CGFloat { get }

    mutating func didClick(recognizer: NSClickGestureRecognizer)
    mutating func didClickExit(recognizer: NSClickGestureRecognizer)
    mutating func didMagnify(recognizer: NSMagnificationGestureRecognizer)
    mutating func didPan(recognizer: NSPanGestureRecognizer)
    mutating func didPress(recognizer: NSPressGestureRecognizer)
    mutating func didRotate(recognizer: NSRotationGestureRecognizer)

    mutating func scrollWheel(with event: NSEvent)
    mutating func mouseMoved(with event: NSEvent)

    mutating func mouseDown(_ location: NSPoint)
    mutating func mouseDragged(_ location: NSPoint)
    mutating func mouseUp(_ location: NSPoint)
    mutating func mouseMoved(_ location: NSPoint)
    #endif
}

public class GestureComponents: GestureComponentsContract {
    public var delegateEvents: [GestureEvent] = []

    #if os(iOS)
    public var isPressed = false
    public var touchX: CGFloat = 0.0
    public var touchY: CGFloat = 0.0
    public var touches: Set<CGPoint> = []
    #elseif os(OSX)
    public var isPressed: Bool = false
    public var mouseX: CGFloat = 0.0
    public var mouseY: CGFloat = 0.0
    #endif

    public init() {}
}

public struct GestureModel: GestureModelContract {
    private var gestureComponents: GestureComponentsContract
    private var frameComponents: FrameComponentsContract

    public init(gestureComponents: GestureComponentsContract,
                frameComponents: FrameComponentsContract) {
        self.gestureComponents = gestureComponents
        self.frameComponents = frameComponents
    }

    #if os(iOS)
    public var fingerPressed: Bool {
        return self.gestureComponents.isPressed
    }

    public var touchX: CGFloat {
        return self.gestureComponents.touches.first?.x ?? 0.0
    }

    public var touchY: CGFloat {
        return self.gestureComponents.touches.first?.y ?? 0.0
    }

    public var touches: Set<CGPoint> {
        return self.gestureComponents.touches
    }
    #elseif os(OSX)
    public var mousePressed: Bool {
        return self.gestureComponents.isPressed
    }

    public var mouseX: CGFloat {
        return self.gestureComponents.mouseX
    }

    public var mouseY: CGFloat {
        return self.gestureComponents.mouseY
    }
    #endif

    #if os(iOS)
    public mutating func touchesBegan(_ touches: Set<CGPoint>) {
        self.gestureComponents.touches = touches
        self.gestureComponents.isPressed = true
    }

    public mutating func touchesMoved(_ touches: Set<CGPoint>) {
        self.gestureComponents.touches = touches
    }

    public mutating func touchesEnded(_ touches: Set<CGPoint>) {
        self.gestureComponents.touches.removeAll()
        self.gestureComponents.isPressed = false
    }

    public mutating func didTap(recognizer: UITapGestureRecognizer) {
        self.touchesBegan(self.touchesFrom(recognizer: recognizer))
        self.gestureComponents.delegateEvents.append(.didTap)
    }
    public mutating func didTapExit(recognizer: UITapGestureRecognizer) {
        self.touchesEnded(self.touchesFrom(recognizer: recognizer))
    }
    public mutating func didPan(recognizer: UIPanGestureRecognizer) {
        self.handleTap(recognizer: recognizer)
        self.gestureComponents.delegateEvents.append(.didDrag)
    }
    public mutating func didSwipe(recognizer: UISwipeGestureRecognizer) {
        self.gestureComponents.delegateEvents.append(.didSwipe(direction: recognizer.direction))
    }
    public mutating func didPinch(recognizer: UIPinchGestureRecognizer) {
        self.handleTap(recognizer: recognizer)
        self.gestureComponents.delegateEvents.append(.didPinch(scale: recognizer.scale, velocity: recognizer.velocity))
    }
    public mutating func didRotate(recognizer: UIRotationGestureRecognizer) {
        self.handleTap(recognizer: recognizer)
        self.gestureComponents.delegateEvents.append(.didRotate(rotation: recognizer.rotation, velocity: recognizer.velocity))
    }
    public mutating func didLongPress(recognizer: UILongPressGestureRecognizer) {
        self.handleTap(recognizer: recognizer)
        self.gestureComponents.delegateEvents.append(.didLongPress)
    }

    private mutating func handleTap(recognizer: UIGestureRecognizer) {
        switch recognizer.state {
        case .possible: return
        case .began:
            self.touchesBegan(touchesFrom(recognizer: recognizer))
        case .changed:
            self.touchesMoved(touchesFrom(recognizer: recognizer))
        case .ended:
            self.touchesEnded(touchesFrom(recognizer: recognizer))
        case .cancelled:
            self.touchesEnded(touchesFrom(recognizer: recognizer))
        case .failed:
            self.touchesEnded(touchesFrom(recognizer: recognizer))
        }
    }

    private func touchesFrom(recognizer: UIGestureRecognizer) -> Set<CGPoint> {
        var touches = Set<CGPoint>()
        let dummyView = UIView(frame: frameComponents.frame)
        for i in 0..<recognizer.numberOfTouches {
            touches.insert(recognizer.location(ofTouch: i, in: dummyView))
        }
        return touches
    }
    #elseif os(OSX)
    public mutating func mouseDown(_ location: NSPoint) {
        self.gestureComponents.mouseX = self.convertCoordinateSystem(location: location).x
        self.gestureComponents.mouseY = self.convertCoordinateSystem(location: location).y
        self.gestureComponents.isPressed = true
    }

    public mutating func mouseDragged(_ location: NSPoint) {
        self.gestureComponents.mouseX = self.convertCoordinateSystem(location: location).x
        self.gestureComponents.mouseY = self.convertCoordinateSystem(location: location).y
    }

    public mutating func mouseUp(_ location: NSPoint) {
        self.gestureComponents.mouseX = self.convertCoordinateSystem(location: location).x
        self.gestureComponents.mouseY = self.convertCoordinateSystem(location: location).y
        self.gestureComponents.isPressed = false
    }

    public mutating func mouseMoved(_ location: NSPoint) {
        self.gestureComponents.mouseX = self.convertCoordinateSystem(location: location).x
        self.gestureComponents.mouseY = self.convertCoordinateSystem(location: location).y
    }

    public mutating func scrollWheel(with event: NSEvent) {
        self.gestureComponents.delegateEvents.append(.didScroll(x: event.deltaX, y: event.deltaY))
    }
    public mutating func mouseMoved(with event: NSEvent) {
        self.gestureComponents.delegateEvents.append(.didMove)

        let dummyView = NSView(frame: frameComponents.frame)
        let location = dummyView.convert(event.locationInWindow, to: nil)
        self.mouseMoved(location)
    }

    public mutating func didClick(recognizer: NSClickGestureRecognizer) {
        self.mouseDown(touchesFrom(recognizer: recognizer))
        self.gestureComponents.delegateEvents.append(.didClick)
    }
    public mutating func didClickExit(recognizer: NSClickGestureRecognizer) {
        self.mouseUp(touchesFrom(recognizer: recognizer))
    }
    public mutating func didMagnify(recognizer: NSMagnificationGestureRecognizer) {
        self.gestureComponents.delegateEvents.append(.didMagnify(magnification: recognizer.magnification))
    }
    public mutating func didPan(recognizer: NSPanGestureRecognizer) {
        handlePress(recognizer: recognizer)
        self.gestureComponents.delegateEvents.append(.didDrag)
    }
    public mutating func didPress(recognizer: NSPressGestureRecognizer) {
        handlePress(recognizer: recognizer)
        self.gestureComponents.delegateEvents.append(.didPress)
    }
    public mutating func didRotate(recognizer: NSRotationGestureRecognizer) {
        self.gestureComponents.delegateEvents.append(.didRotate(rotation: recognizer.rotation, inDegrees: recognizer.rotationInDegrees))
    }

    private mutating func handlePress(recognizer: NSGestureRecognizer) {
        switch recognizer.state {
        case .possible: return
        case .began:
            self.mouseDown(touchesFrom(recognizer: recognizer))
        case .changed:
            self.mouseDragged(touchesFrom(recognizer: recognizer))
        case .ended:
            self.mouseUp(touchesFrom(recognizer: recognizer))
        case .cancelled:
            self.mouseUp(touchesFrom(recognizer: recognizer))
        case .failed:
            self.mouseUp(touchesFrom(recognizer: recognizer))
        }
    }

    private func touchesFrom(recognizer: NSGestureRecognizer) -> NSPoint {
        let dummyView = NSView(frame: frameComponents.frame)
        return recognizer.location(in: dummyView)
    }

    private func convertCoordinateSystem(location: NSPoint) -> NSPoint {
        let height = frameComponents.frame.size.height
        // MARK: Coordinate systems are different between iOS and OS X
        return NSPoint(x: location.x, y: height - location.y)
    }
    #endif
}
