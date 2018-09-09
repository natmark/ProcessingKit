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

public protocol TransformModelContract {
    func pushMatrix()
    func popMatrix()
    func scale(_ s: CGFloat)
    func scale(_ x: CGFloat, _ y: CGFloat)
    func shear(_ angleX: CGFloat, _ angleY: CGFloat)
    func rotate(_ angle: CGFloat)
    func translate(_ x: CGFloat, _ y: CGFloat)
}

public struct TransformModel: TransformModelContract {
    private var contextComponents: ContextComponenetsContract

    public init(contextComponents: ContextComponenetsContract) {
        self.contextComponents = contextComponents
    }

    public func pushMatrix() {
        let g = self.contextComponents.context()
        g?.saveGState()
    }

    public func popMatrix() {
        let g = self.contextComponents.context()
        g?.restoreGState()
    }

    public func scale(_ s: CGFloat) {
        let g = self.contextComponents.context()
        g?.scaleBy(x: s, y: s)

    }

    public func scale(_ x: CGFloat, _ y: CGFloat) {
        let g = self.contextComponents.context()
        g?.scaleBy(x: x, y: y)
    }

    public func shear(_ angleX: CGFloat, _ angleY: CGFloat) {
        let g = self.contextComponents.context()
        g?.concatenate(CGAffineTransform(a: 1, b: tan(angleY), c: tan(angleX), d: 1, tx: 0, ty: 0))
    }

    public func rotate(_ angle: CGFloat) {
        let g = self.contextComponents.context()
        g?.rotate(by: angle)
    }

    public func translate(_ x: CGFloat, _ y: CGFloat) {
        let g = self.contextComponents.context()
        g?.translateBy(x: x, y: y)
    }
}
