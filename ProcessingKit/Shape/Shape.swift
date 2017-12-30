//
//  Graphics.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2017/08/09.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation

protocol ShapeModelContract {
    func point(_ x: CGFloat, _ y: CGFloat)
    func line(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat)
    func rect(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat)
    func ellipse(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat)
    func arc(_ x: CGFloat, _ y: CGFloat, _ radius: CGFloat, _ start: CGFloat, _ stop: CGFloat)
    func triangle(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat, _ x3: CGFloat, _ y3: CGFloat)
    func quad(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat, _ x3: CGFloat, _ y3: CGFloat, _ x4: CGFloat, _ y4: CGFloat)
    func curve(_ cpx1: CGFloat, _ cpy1: CGFloat, _ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat, _ cpx2: CGFloat, _ cpy2: CGFloat)
    func radians(_ degrees: CGFloat) -> CGFloat
}

struct ShapeModel: ShapeModelContract {
    private var colorComponents: ColorComponents

    init(colorComponents: ColorComponents) {
        self.colorComponents = colorComponents
    }

    func point(_ x: CGFloat, _ y: CGFloat) {
        let g = UIGraphicsGetCurrentContext()

        g?.setFillColor(self.colorComponents.stroke.cgColor)
        g?.fill(CGRect(x: x, y: y, width: 1.0, height: 1.0))
    }

    func line(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat) {
        let g = UIGraphicsGetCurrentContext()
        setGraphicsConfiguration(context: g)

        g?.saveGState()

        g?.move(to: CGPoint(x: x1, y: y1))
        g?.addLine(to: CGPoint(x: x2, y: y2))
        g?.strokePath()

        g?.restoreGState()
    }

    func rect(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
        let g = UIGraphicsGetCurrentContext()
        setGraphicsConfiguration(context: g)

        g?.stroke(CGRect(x: x, y: y, width: width, height: height))
        g?.fill(CGRect(x: x, y: y, width: width, height: height))
    }

    func ellipse(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
        let g = UIGraphicsGetCurrentContext()
        setGraphicsConfiguration(context: g)
        g?.strokeEllipse(in: CGRect(x: x - width / 2, y: y - height / 2, width: width, height: height))
        g?.fillEllipse(in: CGRect(x: x - width / 2, y: y - height / 2, width: width, height: height))
    }

    func arc(_ x: CGFloat, _ y: CGFloat, _ radius: CGFloat, _ start: CGFloat, _ stop: CGFloat) {
        let g = UIGraphicsGetCurrentContext()
        setGraphicsConfiguration(context: g)

        g?.saveGState()
        g?.addArc(center: CGPoint(x: x, y: y), radius: radius, startAngle: start, endAngle: stop, clockwise: false)
        g?.drawPath(using: .fillStroke)
        g?.restoreGState()
    }

    func triangle(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat, _ x3: CGFloat, _ y3: CGFloat) {
        let g = UIGraphicsGetCurrentContext()
        setGraphicsConfiguration(context: g)

        g?.saveGState()
        g?.beginPath()
        g?.move(to: CGPoint(x: x1, y: y1))
        g?.addLine(to: CGPoint(x: x2, y: y2))
        g?.addLine(to: CGPoint(x: x3, y: y3))
        g?.closePath()
        g?.drawPath(using: .fillStroke)
        g?.restoreGState()
    }

    func quad(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat, _ x3: CGFloat, _ y3: CGFloat, _ x4: CGFloat, _ y4: CGFloat) {
        let g = UIGraphicsGetCurrentContext()
        setGraphicsConfiguration(context: g)

        g?.saveGState()
        g?.beginPath()
        g?.move(to: CGPoint(x: x1, y: y1))
        g?.addLine(to: CGPoint(x: x2, y: y2))
        g?.addLine(to: CGPoint(x: x3, y: y3))
        g?.addLine(to: CGPoint(x: x4, y: y4))
        g?.closePath()
        g?.drawPath(using: .fillStroke)
        g?.restoreGState()
    }

    func curve(_ cpx1: CGFloat, _ cpy1: CGFloat, _ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat, _ cpx2: CGFloat, _ cpy2: CGFloat) {

        let alpha: CGFloat = 1.0
        let p0 = CGPoint(x: cpx1, y: cpy1)
        let p1 = CGPoint(x: x1, y: y1)
        let p2 = CGPoint(x: x2, y: y2)
        let p3 = CGPoint(x: cpx2, y: cpy2)

        let d1 = p1.deltaTo(p0).length()
        let d2 = p2.deltaTo(p1).length()
        let d3 = p3.deltaTo(p2).length()

        var b1 = p2.multiplyBy(pow(d1, 2 * alpha))
        b1 = b1.deltaTo(p0.multiplyBy(pow(d2, 2 * alpha)))
        b1 = b1.addTo(p1.multiplyBy(2 * pow(d1, 2 * alpha) + 3 * pow(d1, alpha) * pow(d2, alpha) + pow(d2, 2 * alpha)))
        b1 = b1.multiplyBy(1.0 / (3 * pow(d1, alpha) * (pow(d1, alpha) + pow(d2, alpha))))

        var b2 = p1.multiplyBy(pow(d3, 2 * alpha))
        b2 = b2.deltaTo(p3.multiplyBy(pow(d2, 2 * alpha)))
        b2 = b2.addTo(p2.multiplyBy(2 * pow(d3, 2 * alpha) + 3 * pow(d3, alpha) * pow(d2, alpha) + pow(d2, 2 * alpha)))
        b2 = b2.multiplyBy(1.0 / (3 * pow(d3, alpha) * (pow(d3, alpha) + pow(d2, alpha))))

        let g = UIGraphicsGetCurrentContext()
        setGraphicsConfiguration(context: g)

        g?.saveGState()
        g?.move(to: CGPoint(x: x1, y: y1))
        g?.addCurve(to: CGPoint(x: x2, y: y2), control1: CGPoint(x: b1.x, y: b1.y), control2: CGPoint(x: b2.x, y: b2.y))
        g?.drawPath(using: .fillStroke)
        g?.restoreGState()
    }

    func radians(_ degrees: CGFloat) -> CGFloat {
        let radian = (CGFloat.pi * 2) * (degrees / 360.0)
        return radian
    }

    private func setGraphicsConfiguration(context: CGContext?) {
        context?.setFillColor(self.colorComponents.fill.cgColor)
        context?.setStrokeColor(self.colorComponents.stroke.cgColor)
        context?.setLineWidth(self.colorComponents.strokeWeight)
    }
}

// MARK: - ProcessingView Public APIs
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

    public func radians(_ degrees: CGFloat) -> CGFloat {
        return self.shapeModel.radians(degrees)
    }
}
