//
//  ProcessingView+Transform.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2018/09/09.
//  Copyright © 2018年 Atsuya Sato. All rights reserved.
//

import Foundation

#if os(iOS)
import UIKit
#elseif os(OSX)
import Cocoa
#endif

extension ProcessingView: TransformModelContract {
    public func pushMatrix() {
        self.transformModel.pushMatrix()
    }

    public func popMatrix() {
        self.transformModel.popMatrix()
    }

    public func scale(_ s: CGFloat) {
        self.transformModel.scale(s)
    }

    public func scale(_ x: CGFloat, _ y: CGFloat) {
        self.transformModel.scale(x, y)
    }

    public func shear(_ angleX: CGFloat, _ angleY: CGFloat) {
        self.transformModel.shear(angleX, angleY)
    }

    public func rotate(_ angle: CGFloat) {
        self.transformModel.rotate(angle)
    }

    public func translate(_ x: CGFloat, _ y: CGFloat) {
        self.transformModel.translate(x, y)
    }
}
