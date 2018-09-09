//
//  Event.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2017/08/09.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation

#if os(iOS)
import UIKit
#elseif os(OSX)
import Cocoa
#endif

public protocol EventComponentsContract {
    #if os(iOS)
    var fingerTapped: Bool { get set }
    var fingerDragged: Bool { get set }
    var fingerPressed: Bool { get set }
    var fingerReleased: Bool { get set }
    var touchX: CGFloat { get set }
    var touchY: CGFloat { get set }
    var touchesX: Set<CGFloat> { get set }
    var touchesY: Set<CGFloat> { get set }
    #elseif os(OSX)
    var mouseClicked: Bool { get set }
    var mouseDragged: Bool { get set }
    var mouseMoved: Bool { get set }
    var mousePressed: Bool { get set }
    var mouseReleased: Bool { get set }
    var mouseX: CGFloat { get set }
    var mouseY: CGFloat { get set }
    #endif
}

public protocol EventModelContract {
    #if os(iOS)
    var fingerPressed: Bool { get }
    var touchX: CGFloat { get }
    var touchY: CGFloat { get }
    var touchesX: Set<CGFloat> { get }
    var touchesY: Set<CGFloat> { get }
    mutating func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    mutating func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    mutating func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    #elseif os(OSX)
    var mousePressed: Bool { get }
    var mouseX: CGFloat { get }
    var mouseY: CGFloat { get }
    mutating func mouseDown(with event: NSEvent)
    mutating func mouseDragged(with event: NSEvent)
    mutating func mouseUp(with event: NSEvent)
    mutating func mouseMoved(with event: NSEvent)
    #endif
}

public class EventComponents: EventComponentsContract {
    #if os(iOS)
    public var fingerTapped = false
    public var fingerDragged = false
    public var fingerPressed = false
    public var fingerReleased = false
    public var touchX: CGFloat = 0.0
    public var touchY: CGFloat = 0.0
    public var touchesX: Set<CGFloat> = []
    public var touchesY: Set<CGFloat> = []
    #elseif os(OSX)
    public var mouseClicked = false
    public var mouseDragged = false
    public var mouseMoved = false
    public var mousePressed = false
    public var mouseReleased = false
    public var mouseX: CGFloat = 0.0
    public var mouseY: CGFloat = 0.0
    #endif

    public init() {}
}

public struct EventModel: EventModelContract {
    private var eventComponents: EventComponentsContract
    private var frameComponents: FrameComponentsContract
    private var superView: UIView?
    private lazy var dummyView: UIView = {
        var parent = superView
        var point = CGPoint.zero

        while parent != nil {
            point.x += parent?.frame.origin.x ?? 0.0
            point.y += parent?.frame.origin.y ?? 0.0
            parent = parent?.superview
        }
        let frame = CGRect(
            x: self.frameComponents.frame.origin.x + point.x,
            y: self.frameComponents.frame.origin.y + point.y,
            width: self.frameComponents.frame.size.width,
            height: self.frameComponents.frame.size.height
        )

        return UIView(frame: frame)
    }()

    public init(frameComponents: FrameComponentsContract, eventComponents: EventComponentsContract, superView: UIView?) {
        self.frameComponents = frameComponents
        self.eventComponents = eventComponents
        self.superView = superView
    }

    #if os(iOS)
    public var fingerPressed: Bool {
        return self.eventComponents.fingerPressed
    }

    public var touchX: CGFloat {
        return self.eventComponents.touchX
    }

    public var touchY: CGFloat {
        return self.eventComponents.touchY
    }

    public var touchesX: Set<CGFloat> {
        return self.eventComponents.touchesX
    }

    public var touchesY: Set<CGFloat> {
        return self.eventComponents.touchesY
    }
    #elseif os(OSX)
    public var mousePressed: Bool {
        return self.eventComponents.mousePressed
    }

    public var mouseX: CGFloat {
        return self.eventComponents.mouseX
    }

    public var mouseY: CGFloat {
        return self.eventComponents.mouseY
    }
    #endif

    #if os(iOS)
    public mutating func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.storeTouches(touches)
        self.eventComponents.fingerPressed = true
        self.eventComponents.fingerTapped = true
    }

    public mutating func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.storeTouches(touches)
        self.eventComponents.fingerDragged = true
    }

    public mutating func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.storeTouches(touches)
        self.eventComponents.fingerTapped = false
        self.eventComponents.fingerReleased = true

        if touchesX.isEmpty {
            self.eventComponents.fingerPressed = false
        }
    }

    private mutating func storeTouches(_ touches: Set<UITouch>) {
        self.eventComponents.touchesX.removeAll()
        self.eventComponents.touchesY.removeAll()
        for (index, touch) in touches.enumerated() {
            if touch.phase != UITouchPhase.ended && touch.phase != UITouchPhase.cancelled {
                let touchX = touch.location(in: self.dummyView).x
                let touchY = touch.location(in: self.dummyView).y
                self.eventComponents.touchesX.insert(touchX)
                self.eventComponents.touchesY.insert(touchY)
                if index == 0 {
                    self.eventComponents.touchX = touchX
                    self.eventComponents.touchY = touchY
                }
            }
        }
    }
    #elseif os(OSX)
    public mutating func mouseDown(with event: NSEvent) {
        self.storeTouch(event.locationInWindow)

        self.eventComponents.mousePressed = true
        self.eventComponents.mouseClicked = true
    }

    public mutating func mouseDragged(with event: NSEvent) {
        self.storeTouch(event.locationInWindow)

        self.eventComponents.mouseDragged = true
    }

    public mutating func mouseUp(with event: NSEvent) {
        self.storeTouch(event.locationInWindow)

        self.eventComponents.mousePressed = false
        self.eventComponents.mouseReleased = true
    }

    public mutating func mouseMoved(with event: NSEvent) {
        self.storeTouch(event.locationInWindow)

        self.eventComponents.mouseMoved = true
    }

    private mutating func storeTouch(_ point: NSPoint) {
        self.eventComponents.mouseX = point.x
        // MARK: Coordinate systems are different between iOS and OS X
        self.eventComponents.mouseY = self.frameComponents.bounds.height - point.y
    }
    #endif
}
