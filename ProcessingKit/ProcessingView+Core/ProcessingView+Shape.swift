//
//  ProcessingView+Shape.swift
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

extension ProcessingView: ShapeModelContract {
    public func point(_ x: CGFloat, _ y: CGFloat) {
        self.shapeModel.point(x, y)
    }

    public func line(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat) {
        self.shapeModel.line(x1, y1, x2, y2)
    }

    public func rect(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
        self.shapeModel.rect(x, y, width, height)
    }

    public func ellipse(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
        self.shapeModel.ellipse(x, y, width, height)
    }

    public func arc(_ x: CGFloat, _ y: CGFloat, _ radius: CGFloat, _ start: CGFloat, _ stop: CGFloat) {
        self.shapeModel.arc(x, y, radius, start, stop)
    }

    public func triangle(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat, _ x3: CGFloat, _ y3: CGFloat) {
        self.shapeModel.triangle(x1, y1, x2, y2, x3, y3)
    }

    public func quad(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat, _ x3: CGFloat, _ y3: CGFloat, _ x4: CGFloat, _ y4: CGFloat) {
        self.shapeModel.quad(x1, y1, x2, y2, x3, y3, x4, y4)
    }

    public func curve(_ cpx1: CGFloat, _ cpy1: CGFloat, _ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat, _ cpx2: CGFloat, _ cpy2: CGFloat) {
        self.shapeModel.curve(cpx1, cpy1, x1, y1, x2, y2, cpx2, cpy2)
    }

    public func bezier(_ x1: CGFloat, _ y1: CGFloat, _ cpx1: CGFloat, _ cpy1: CGFloat, _ cpx2: CGFloat, _ cpy2: CGFloat, _ x2: CGFloat, _ y2: CGFloat) {
        self.shapeModel.bezier(x1, y1, cpx1, cpy1, cpx2, cpy2, x2, y2)
    }

    public func radians(_ degrees: CGFloat) -> CGFloat {
        return self.shapeModel.radians(degrees)
    }
}
