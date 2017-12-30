//
//  Event.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2017/08/09.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

#if !os(iOS)
import Cocoa
#endif

import Foundation

class EventComponents {
    var fingerTapped = false
    var fingerMoved = false
    var fingerReleased = false
    var fingerPressed = false
    var touchX: CGFloat = 0.0
    var touchY: CGFloat = 0.0
    var touchesX: Set<CGFloat> = []
    var touchesY: Set<CGFloat> = []
}

protocol EventModelContract {
    var fingerPressed: Bool { get }
    var touchX: CGFloat { get }
    var touchY: CGFloat { get }
    var touchesX: Set<CGFloat> { get }
    var touchesY: Set<CGFloat> { get }
    #if os(iOS)
    mutating func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    mutating func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    mutating func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    #else
    mutating func touchesBegan(with event: NSEvent)
    mutating func touchesMoved(with event: NSEvent)
    mutating func touchesEnded(with event: NSEvent)
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

    #if os(iOS)
    mutating func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.storeTouches(touches)
        self.eventComponents.fingerPressed = true
        self.eventComponents.fingerTapped = true
    }

    mutating func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.storeTouches(touches)
        self.eventComponents.fingerMoved = true
    }

    mutating func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.storeTouches(touches)
        self.eventComponents.fingerTapped = false
        self.eventComponents.fingerReleased = true
    }
    #else
    mutating func touchesBegan(with event: NSEvent) {
        self.storeTouches(event.touches(matching: .any, in: nil))
        self.eventComponents.fingerPressed = true
        self.eventComponents.fingerTapped = true
    }
    mutating func touchesMoved(with event: NSEvent) {
        self.storeTouches(event.touches(matching: .any, in: nil))
        self.eventComponents.fingerMoved = true
    }
    mutating func touchesEnded(with event: NSEvent) {
        self.storeTouches(event.touches(matching: .any, in: nil))
        self.eventComponents.fingerTapped = false
        self.eventComponents.fingerReleased = true
    }
    #endif

    private mutating func storeTouches(_ touches: Set<UITouch>) {
        self.eventComponents.touchesX.removeAll()
        self.eventComponents.touchesY.removeAll()
        for (index, touch) in touches.enumerated() {
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

// MARK: - ProcessingView Public APIs
extension ProcessingView: EventModelContract {
    public var fingerPressed: Bool {
        return self.eventModel.fingerPressed
    }

    public var touchX: CGFloat {
        return self.eventModel.touchX
    }

    public var touchY: CGFloat {
        return self.eventModel.touchY
    }

    var touchesX: Set<CGFloat> {
        return self.eventModel.touchesX
    }

    var touchesY: Set<CGFloat> {
        return self.eventModel.touchesY
    }

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
    #else
    open override func touchesBegan(with event: NSEvent) {
        self.eventModel.touchesBegan(with: event)
    }
    open override func touchesMoved(with event: NSEvent) {
        self.eventModel.touchesMoved(with: event)
    }
    open override func touchesEnded(with event: NSEvent) {
        self.eventModel.touchesEnded(with: event)
    }
    #endif
}
