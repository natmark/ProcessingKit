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

    func rotate(angle: CGFloat) {
        let g = UIGraphicsGetCurrentContext()
        g?.rotate(by: angle)
    }

    func translate(x: CGFloat, y: CGFloat) {
        let g = UIGraphicsGetCurrentContext()
        g?.translateBy(x: x, y: y)
    }
}
