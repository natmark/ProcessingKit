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

class EventComponents {
    #if os(iOS)
    var fingerTapped = false
    var fingerDragged = false
    var fingerPressed = false
    var fingerReleased = false
    var touchX: CGFloat = 0.0
    var touchY: CGFloat = 0.0
    var touchesX: Set<CGFloat> = []
    var touchesY: Set<CGFloat> = []
    #elseif os(OSX)
    var mouseClicked = false
    var mouseDragged = false
    var mouseMoved = false
    var mousePressed = false
    var mouseReleased = false
    var mouseX: CGFloat = 0.0
    var mouseY: CGFloat = 0.0
    #endif
}

protocol EventModelContract {
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

struct EventModel: EventModelContract {
    private var eventComponents: EventComponents
    private var frameComponents: FrameComponents
    lazy var dummyView: UIView = {
        return UIView(frame: self.frameComponents.frame)
    }()

    init(frameComponents: FrameComponents, eventComponents: EventComponents) {
        self.frameComponents = frameComponents
        self.eventComponents = eventComponents
    }

    #if os(iOS)
    var fingerPressed: Bool {
        return self.eventComponents.fingerPressed
    }

    var touchX: CGFloat {
        return self.eventComponents.touchX
    }

    var touchY: CGFloat {
        return self.eventComponents.touchY
    }

    var touchesX: Set<CGFloat> {
        return self.eventComponents.touchesX
    }

    var touchesY: Set<CGFloat> {
        return self.eventComponents.touchesY
    }
    #elseif os(OSX)
    var mousePressed: Bool {
        return self.eventComponents.mousePressed
    }

    var mouseX: CGFloat {
        return self.eventComponents.mouseX
    }

    var mouseY: CGFloat {
        return self.eventComponents.mouseY
    }
    #endif

    #if os(iOS)
    mutating func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.storeTouches(touches)
        self.eventComponents.fingerPressed = true
        self.eventComponents.fingerTapped = true
    }

    mutating func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.storeTouches(touches)
        self.eventComponents.fingerDragged = true
    }

    mutating func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
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
    mutating func mouseDown(with event: NSEvent) {
        self.storeTouch(event.locationInWindow)

        self.eventComponents.mousePressed = true
        self.eventComponents.mouseClicked = true
    }

    mutating func mouseDragged(with event: NSEvent) {
        self.storeTouch(event.locationInWindow)

        self.eventComponents.mouseDragged = true
    }

    mutating func mouseUp(with event: NSEvent) {
        self.storeTouch(event.locationInWindow)

        self.eventComponents.mousePressed = false
        self.eventComponents.mouseReleased = true
    }

    mutating func mouseMoved(with event: NSEvent) {
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

// MARK: - ProcessingView Public APIs
extension ProcessingView: EventModelContract {
    #if os(iOS)
    public var fingerPressed: Bool {
        return self.eventModel.fingerPressed
    }

    public var touchX: CGFloat {
        return self.eventModel.touchX
    }

    public var touchY: CGFloat {
        return self.eventModel.touchY
    }

    public var touchesX: Set<CGFloat> {
        return self.eventModel.touchesX
    }

    public var touchesY: Set<CGFloat> {
        return self.eventModel.touchesY
    }
    #elseif os(OSX)
    public var mousePressed: Bool {
        return self.eventModel.mousePressed
    }

    public var mouseX: CGFloat {
        return self.eventModel.mouseX
    }

    public var mouseY: CGFloat {
        return self.eventModel.mouseY
    }

    #endif

    #if os(iOS)
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.eventModel.touchesBegan(touches, with: event)
    }

    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.eventModel.touchesMoved(touches, with: event)
    }

    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.eventModel.touchesEnded(touches, with: event)
    }
    #elseif os(OSX)
    open override func mouseDown(with event: NSEvent) {
        self.eventModel.mouseDown(with: event)
    }

    open override func mouseDragged(with event: NSEvent) {
        self.eventModel.mouseDragged(with: event)
    }

    open override func mouseUp(with event: NSEvent) {
        self.eventModel.mouseUp(with: event)
    }

    open override func mouseMoved(with event: NSEvent) {
        self.eventModel.mouseMoved(with: event)
    }
    #endif
}
