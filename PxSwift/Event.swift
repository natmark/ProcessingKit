//
//  Event.swift
//  PxSwift
//
//  Created by AtsuyaSato on 2017/08/09.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation

extension PxView {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if let touch = touches.first {
            self.touchX = touch.location(in: self).x
            self.touchY = touch.location(in: self).y
        }
        self.fingerPressed = true
        self.fingerTapped = true
    }
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if let touch = touches.first {
            self.touchX = touch.location(in: self).x
            self.touchY = touch.location(in: self).y
        }
        self.fingerMoved = true
    }
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if let touch = touches.first {
            self.touchX = touch.location(in: self).x
            self.touchY = touch.location(in: self).y
        }
        self.fingerPressed = false
        self.fingerReleased = true
    }
}
