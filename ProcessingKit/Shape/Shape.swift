//
//  Graphics.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2017/08/09.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation

public protocol Shape {
    func point(_ x: CGFloat, _ y: CGFloat)
    func line(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat)
    func rect(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat)
    func ellipse(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat)
}

extension ProcessingView: Shape {
    func setGraphicsConfiguration(context: CGContext?) {
        context?.setFillColor(self.colorComponents.fill_.cgColor)
        context?.setStrokeColor(self.colorComponents.stroke_.cgColor)
        context?.setLineWidth(self.colorComponents.strokeWeight_)
    }

    public func point(_ x: CGFloat, _ y: CGFloat) {
        let g = UIGraphicsGetCurrentContext()

        g?.setFillColor(self.colorComponents.stroke_.cgColor)
        g?.fill(CGRect(x: x, y: y, width: 1.0, height: 1.0))
    }

    public func line(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat) {
        let g = UIGraphicsGetCurrentContext()
        g?.saveGState()

        setGraphicsConfiguration(context: g)
        g?.move(to: CGPoint(x: x1, y: y1))
        g?.addLine(to: CGPoint(x: x2, y: y2))
        g?.strokePath()

        g?.restoreGState()
    }

    public func rect(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
        let g = UIGraphicsGetCurrentContext()
        setGraphicsConfiguration(context: g)

        g?.stroke(CGRect(x: x, y: y, width: width, height: height))
        g?.fill(CGRect(x: x, y: y, width: width, height: height))
    }

    public func ellipse(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
        let g = UIGraphicsGetCurrentContext()
        setGraphicsConfiguration(context: g)

        g?.strokeEllipse(in: CGRect(x: x - width / 2, y: y - height / 2, width: width, height: height))
        g?.fillEllipse(in: CGRect(x: x - width / 2, y: y - height / 2, width: width, height: height))
    }
}
