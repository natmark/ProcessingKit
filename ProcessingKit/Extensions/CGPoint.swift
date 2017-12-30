//
//  CGPoint.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2017/12/30.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

extension CGPoint {
    func addTo(_ a: CGPoint) -> CGPoint {
        return CGPoint(x: self.x + a.x, y: self.y + a.y)
    }

    func deltaTo(_ a: CGPoint) -> CGPoint {
        return CGPoint(x: self.x - a.x, y: self.y - a.y)
    }

    func multiplyBy(_ value: CGFloat) -> CGPoint {
        return CGPoint(x: self.x * value, y: self.y * value)
    }

    func length() -> CGFloat {
        return CGFloat(sqrt(CDouble(
            self.x*self.x + self.y*self.y
        )))
    }
}
