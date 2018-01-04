//
//  Transform.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2017/09/27.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation

#if os(iOS)
import UIKit
#elseif os(OSX)
import Cocoa
#endif

protocol TransformModelContract {
    func pushMatrix()
    func popMatrix()
    func scale(_ s: CGFloat)
    func scale(_ x: CGFloat, _ y: CGFloat)
    func shere(_ angleX: CGFloat, _ angleY: CGFloat)
    func rotate(_ angle: CGFloat)
    func translate(_ x: CGFloat, _ y: CGFloat)
}

struct TransformModel: TransformModelContract {
    func pushMatrix() {
        let g = MultiplatformCommon.getCurrentContext()
        g?.saveGState()
    }

    func popMatrix() {
        let g = MultiplatformCommon.getCurrentContext()
        g?.restoreGState()
    }

    func scale(_ s: CGFloat) {
        let g = MultiplatformCommon.getCurrentContext()
        g?.scaleBy(x: s, y: s)

    }

    func scale(_ x: CGFloat, _ y: CGFloat) {
        let g = MultiplatformCommon.getCurrentContext()
        g?.scaleBy(x: x, y: y)
    }

    func shere(_ angleX: CGFloat, _ angleY: CGFloat) {
        let g = MultiplatformCommon.getCurrentContext()
        g?.concatenate(CGAffineTransform(a: 1, b: angleY, c: angleX, d: 1, tx: 0, ty: 0))
    }

    func rotate(_ angle: CGFloat) {
        let g = MultiplatformCommon.getCurrentContext()
        g?.rotate(by: angle)
    }

    func translate(_ x: CGFloat, _ y: CGFloat) {
        let g = MultiplatformCommon.getCurrentContext()
        g?.translateBy(x: x, y: y)
    }
}

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

    public func shere(_ angleX: CGFloat, _ angleY: CGFloat) {
        self.transformModel.shere(angleX, angleY)
    }

    public func rotate(_ angle: CGFloat) {
        self.transformModel.rotate(angle)
    }

    public func translate(_ x: CGFloat, _ y: CGFloat) {
        self.transformModel.translate(x, y)
    }
}
