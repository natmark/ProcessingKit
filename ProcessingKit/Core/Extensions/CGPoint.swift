//
//  CGPoint.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2017/12/30.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

#if os(iOS)
import UIKit
#elseif os(OSX)
import Cocoa
#endif

extension CGPoint: Hashable {
    func distance(point: CGPoint) -> Float {
        let dx = Float(x - point.x)
        let dy = Float(y - point.y)
        return sqrt((dx * dx) + (dy * dy))
    }
    public var hashValue: Int {
        return x.hashValue << 32 ^ y.hashValue
    }
}

func == (lhs: CGPoint, rhs: CGPoint) -> Bool {
    return lhs.distance(point: rhs) < 0.000001
}

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
