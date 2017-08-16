//
//  Event.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2017/08/09.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation

struct EventComponents {
    var fingerTapped = false
    var fingerMoved = false
    var fingerReleased = false
    var fingerPressed = true
    var touchX: CGFloat = 0.0
    var touchY: CGFloat = 0.0
}

public protocol Event {
    var fingerPressed: Bool { get }
    var touchX: CGFloat { get }
    var touchY: CGFloat { get }
}

extension ProcessingView: Event {
    public var fingerPressed: Bool {
        return self.eventComponents.fingerPressed
    }

    public var touchX: CGFloat {
        return self.eventComponents.touchX
    }

    public var touchY: CGFloat {
        return self.eventComponents.touchY
    }

    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            self.eventComponents.touchX = touch.location(in: self).x
            self.eventComponents.touchY = touch.location(in: self).y
        }
        self.eventComponents.fingerPressed = true
        self.eventComponents.fingerTapped = true
    }

    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            self.eventComponents.touchX = touch.location(in: self).x
            self.eventComponents.touchY = touch.location(in: self).y
        }
        self.eventComponents.fingerMoved = true
    }

    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            self.eventComponents.touchX = touch.location(in: self).x
            self.eventComponents.touchY = touch.location(in: self).y
        }
        self.eventComponents.fingerTapped = false
        self.eventComponents.fingerReleased = true
    }
}
