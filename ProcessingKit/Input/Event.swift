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

protocol EventModelContractor {
    var fingerPressed: Bool { get }
    var touchX: CGFloat { get }
    var touchY: CGFloat { get }
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
}

struct EventModel: EventModelContractor {
    private var eventComponents: EventComponents
    private var processingView: ProcessingView

    init(processingView: ProcessingView, eventComponents: EventComponents) {
        self.processingView = processingView
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

    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            self.eventComponents.touchX = touch.location(in: self.processingView).x
            self.eventComponents.touchY = touch.location(in: self.processingView).y
        }
        self.eventComponents.fingerPressed = true
        self.eventComponents.fingerTapped = true
    }

    func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            self.eventComponents.touchX = touch.location(in: self.processingView).x
            self.eventComponents.touchY = touch.location(in: self.processingView).y
        }
        self.eventComponents.fingerMoved = true
    }

    func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            self.eventComponents.touchX = touch.location(in: self.processingView).x
            self.eventComponents.touchY = touch.location(in: self.processingView).y
        }
        self.eventComponents.fingerTapped = false
        self.eventComponents.fingerReleased = true
    }
}

extension ProcessingView: EventModelContractor {
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
