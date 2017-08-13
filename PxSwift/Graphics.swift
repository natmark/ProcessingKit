//
//  Graphics.swift
//  PxSwift
//
//  Created by AtsuyaSato on 2017/08/09.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation

struct GraphicsComponents {
    var fill_: UIColor = UIColor.white
    var stroke_: UIColor = UIColor.clear
    var strokeWeight_: CGFloat = 1.0
}

public protocol Graphics {
    func line(_ x1: CGFloat, _ y1: CGFloat, _ x2:CGFloat, _ y2: CGFloat)
    func rect(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat)
    func ellipse(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat)
    func background(_ color: UIColor)

    func fill(_ color: UIColor)
    func stroke(_ color: UIColor)
    func strokeWeight(_ weight: CGFloat)
    func noFill()
    func noStroke()
}

extension PxView: Graphics {
    func setGraphicsConfiguration(context: CGContext?) {
        context?.setFillColor(self.graphicsComponents.fill_.cgColor)
        context?.setStrokeColor(self.graphicsComponents.stroke_.cgColor)
        context?.setLineWidth(self.graphicsComponents.strokeWeight_)
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

    public func background(_ color: UIColor) {
        let g = UIGraphicsGetCurrentContext()
        g!.clear(self.bounds)
        self.backgroundColor = color
    }

    public func fill(_ color: UIColor) {
        self.graphicsComponents.fill_ = color
    }

    public func stroke(_ color: UIColor) {
        self.graphicsComponents.stroke_ = color
    }

    public func strokeWeight(_ weight: CGFloat) {
        self.graphicsComponents.strokeWeight_ = weight
    }

    public func noFill() {
        self.graphicsComponents.fill_ = UIColor.clear
    }

    public func noStroke() {
        self.graphicsComponents.stroke_ = UIColor.clear
    }
}
