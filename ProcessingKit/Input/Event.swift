//
//  Event.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2017/08/09.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation

class EventComponents {
    var fingerTapped = false
    var fingerMoved = false
    var fingerReleased = false
    var fingerPressed = true
    var touchX: CGFloat = 0.0
    var touchY: CGFloat = 0.0
}

protocol EventModelContract {
    var fingerPressed: Bool { get }
    var touchX: CGFloat { get }
    var touchY: CGFloat { get }
    mutating func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    mutating func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    mutating func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
}

struct EventModel: EventModelContract {
    private var eventComponents: EventComponents
    private var frameComponents: FrameComponents
    lazy var dummyView: UIView = {
        return UIView(frame: self.frameComponents.bounds)
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

    mutating func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            self.eventComponents.touchX = touch.location(in: self.dummyView).x
            self.eventComponents.touchY = touch.location(in: self.dummyView).y
        }
        self.eventComponents.fingerPressed = true
        self.eventComponents.fingerTapped = true
    }

    mutating func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            self.eventComponents.touchX = touch.location(in: self.dummyView).x
            self.eventComponents.touchY = touch.location(in: self.dummyView).y
        }
        self.eventComponents.fingerMoved = true
    }

    mutating func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            self.eventComponents.touchX = touch.location(in: self.dummyView).x
            self.eventComponents.touchY = touch.location(in: self.dummyView).y
        }
        self.eventComponents.fingerTapped = false
        self.eventComponents.fingerReleased = true
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

    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.eventModel.touchesBegan(touches, with: event)
    }

    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.eventModel.touchesMoved(touches, with: event)
    }

    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.eventModel.touchesEnded(touches, with: event)
    }
}
