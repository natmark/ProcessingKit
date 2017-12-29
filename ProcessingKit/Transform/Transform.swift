//
//  Transform.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2017/09/27.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation

protocol TransformModelContract {
    func pushMatrix()
    func popMatrix()
    func scale(s: CGFloat)
    func scale(x: CGFloat, y: CGFloat)
    func shere(angleX: CGFloat, angleY: CGFloat)
    func rotate(angle: CGFloat)
    func translate(x: CGFloat, y: CGFloat)
}

struct TransformModel: TransformModelContract {
    func pushMatrix() {
        let g = UIGraphicsGetCurrentContext()
        g?.saveGState()
    }

    func popMatrix() {
        let g = UIGraphicsGetCurrentContext()
        g?.restoreGState()
    }

    func scale(s: CGFloat) {
        let g = UIGraphicsGetCurrentContext()
        g?.scaleBy(x: s, y: s)

    }

    func scale(x: CGFloat, y: CGFloat) {
        let g = UIGraphicsGetCurrentContext()
        g?.scaleBy(x: x, y: y)
    }

    func shere(angleX: CGFloat, angleY: CGFloat) {
        let g = UIGraphicsGetCurrentContext()
        g?.concatenate(CGAffineTransform(a: 1, b: angleY, c: angleX, d: 1, tx: 0, ty: 0))
    }

    func rotate(angle: CGFloat) {
        let g = UIGraphicsGetCurrentContext()
        g?.rotate(by: angle)
    }

    func translate(x: CGFloat, y: CGFloat) {
        let g = UIGraphicsGetCurrentContext()
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

    public func scale(s: CGFloat) {
        self.transformModel.scale(s: s)
    }

    public func scale(x: CGFloat, y: CGFloat) {
        self.transformModel.scale(x: x, y: y)
    }

    public func shere(angleX: CGFloat, angleY: CGFloat) {
        self.transformModel.shere(angleX: angleX, angleY: angleY)
    }

    public func rotate(angle: CGFloat) {
        self.transformModel.rotate(angle: angle)
    }

    public func translate(x: CGFloat, y: CGFloat) {
        self.transformModel.translate(x: x, y: y)
    }
}
