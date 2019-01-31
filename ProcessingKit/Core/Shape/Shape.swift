//
//  Graphics.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2017/08/09.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation

#if os(iOS)
import UIKit
#elseif os(OSX)
import Cocoa
#endif

public protocol ShapeModelContract {
    func point(_ x: CGFloat, _ y: CGFloat)
    func line(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat)
    func rect(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat)
    func rect(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat, _ radius: CGFloat)
    func rect(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat, _ topLeftRadius: CGFloat, _ topRightRadius: CGFloat, _ bottomLeftRadius: CGFloat, _ bottomRightRadius: CGFloat)
    func ellipse(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat)
    func arc(_ x: CGFloat, _ y: CGFloat, _ radius: CGFloat, _ start: CGFloat, _ stop: CGFloat)
    func triangle(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat, _ x3: CGFloat, _ y3: CGFloat)
    func quad(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat, _ x3: CGFloat, _ y3: CGFloat, _ x4: CGFloat, _ y4: CGFloat)
    func curve(_ cpx1: CGFloat, _ cpy1: CGFloat, _ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat, _ cpx2: CGFloat, _ cpy2: CGFloat)
    func bezier(_ x1: CGFloat, _ y1: CGFloat, _ cpx1: CGFloat, _ cpy1: CGFloat, _ cpx2: CGFloat, _ cpy2: CGFloat, _ x2: CGFloat, _ y2: CGFloat)
    func radians(_ degrees: CGFloat) -> CGFloat
}

public struct ShapeModel: ShapeModelContract {
    private var colorComponents: ColorComponentsContract
    private var contextComponents: ContextComponenetsContract

    public init(contextComponents: ContextComponenetsContract, colorComponents: ColorComponentsContract) {
        self.contextComponents = contextComponents
        self.colorComponents = colorComponents
    }

    public func point(_ x: CGFloat, _ y: CGFloat) {
        let g = self.contextComponents.context()
        g?.setFillColor(self.colorComponents.stroke.cgColor)

        drawing(mode: .fill) {
            let width = self.colorComponents.strokeWeight
            let height = self.colorComponents.strokeWeight
            g?.addEllipse(in: CGRect(x: x - width / 2, y: y - height / 2, width: width, height: height))
        }
    }

    public func line(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat) {
        let g = self.contextComponents.context()
        setGraphicsConfiguration(context: g)

        drawing(mode: .stroke) {
            g?.move(to: CGPoint(x: x1, y: y1))
            g?.addLine(to: CGPoint(x: x2, y: y2))
        }
    }

    public func rect(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
        let g = self.contextComponents.context()
        setGraphicsConfiguration(context: g)

        drawing(mode: .fillStroke) {
            g?.addRect(CGRect(x: x, y: y, width: width, height: height))
        }
    }

    public func rect(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat, _ radius: CGFloat) {
        self.rect(x, y, width, height, radius, radius, radius, radius)
    }

    public func rect(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat, _ topLeftRadius: CGFloat, _ topRightRadius: CGFloat, _ bottomLeftRadius: CGFloat, _ bottomRightRadius: CGFloat) {
        let g = self.contextComponents.context()
        setGraphicsConfiguration(context: g)

        var topLeftRadius = topLeftRadius
        var topRightRadius = topRightRadius
        var bottomLeftRadius = bottomLeftRadius
        var bottomRightRadius = bottomRightRadius
        if topLeftRadius > min(width, height) / 2 {
            topLeftRadius = min(width, height) / 2
        }
        if topRightRadius > min(width, height) / 2 {
            topRightRadius = min(width, height) / 2
        }
        if bottomLeftRadius > min(width, height) / 2 {
            bottomLeftRadius = min(width, height) / 2
        }
        if bottomRightRadius > min(width, height) / 2 {
            bottomRightRadius = min(width, height) / 2
        }

        drawing(mode: .fillStroke) {
            g?.beginPath()
            g?.move(to: CGPoint(x: x + topLeftRadius, y: y))

            g?.addLine(to: CGPoint(x: x + width - topRightRadius, y: y))
            g?.addArc(center: CGPoint(x: x + width - topRightRadius, y: y + topRightRadius), radius: topRightRadius, startAngle: radians(-90), endAngle: radians(0), clockwise: false)

            g?.addLine(to: CGPoint(x: x + width, y: y + height - bottomRightRadius))
            g?.addArc(center: CGPoint(x: x + width - bottomRightRadius, y: y + height - bottomRightRadius), radius: bottomRightRadius, startAngle: radians(0), endAngle: radians(90), clockwise: false)

            g?.addLine(to: CGPoint(x: x + bottomLeftRadius, y: y + height))
            g?.addArc(center: CGPoint(x: x + bottomLeftRadius, y: y + height - bottomLeftRadius), radius: bottomLeftRadius, startAngle: radians(90), endAngle: radians(180), clockwise: false)

            g?.addLine(to: CGPoint(x: x, y: y + topLeftRadius))
            g?.addArc(center: CGPoint(x: x + topLeftRadius, y: y + topLeftRadius), radius: topLeftRadius, startAngle: radians(180), endAngle: radians(270), clockwise: false)

            g?.closePath()
        }
    }

    public func ellipse(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
        let g = self.contextComponents.context()
        setGraphicsConfiguration(context: g)

        drawing(mode: .fillStroke) {
            g?.addEllipse(in: CGRect(x: x - width / 2, y: y - height / 2, width: width, height: height))
        }
    }

    public func arc(_ x: CGFloat, _ y: CGFloat, _ radius: CGFloat, _ start: CGFloat, _ stop: CGFloat) {
        let g = self.contextComponents.context()
        setGraphicsConfiguration(context: g)

        drawing(mode: .fillStroke) {
            g?.addArc(center: CGPoint(x: x, y: y), radius: radius, startAngle: start, endAngle: stop, clockwise: false)
        }
    }

    public func triangle(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat, _ x3: CGFloat, _ y3: CGFloat) {
        let g = self.contextComponents.context()
        setGraphicsConfiguration(context: g)

        drawing(mode: .fillStroke) {
            g?.beginPath()
            g?.move(to: CGPoint(x: x1, y: y1))
            g?.addLine(to: CGPoint(x: x2, y: y2))
            g?.addLine(to: CGPoint(x: x3, y: y3))
            g?.closePath()
        }
    }

    public func quad(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat, _ x3: CGFloat, _ y3: CGFloat, _ x4: CGFloat, _ y4: CGFloat) {
        let g = self.contextComponents.context()
        setGraphicsConfiguration(context: g)

        drawing(mode: .fillStroke) {
            g?.beginPath()
            g?.move(to: CGPoint(x: x1, y: y1))
            g?.addLine(to: CGPoint(x: x2, y: y2))
            g?.addLine(to: CGPoint(x: x3, y: y3))
            g?.addLine(to: CGPoint(x: x4, y: y4))
            g?.closePath()
        }
    }

    public func curve(_ cpx1: CGFloat, _ cpy1: CGFloat, _ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat, _ cpx2: CGFloat, _ cpy2: CGFloat) {
        let g = self.contextComponents.context()
        setGraphicsConfiguration(context: g)

        let (b1, b2) = ShapeModel.convertCurvePoint(cpx1, cpy1, x1, y1, x2, y2, cpx2, cpy2)

        drawing(mode: .fillStroke) {
            g?.move(to: CGPoint(x: x1, y: y1))
            g?.addCurve(to: CGPoint(x: x2, y: y2), control1: CGPoint(x: b1.x, y: b1.y), control2: CGPoint(x: b2.x, y: b2.y))
        }
    }

    public func bezier(_ x1: CGFloat, _ y1: CGFloat, _ cpx1: CGFloat, _ cpy1: CGFloat, _ cpx2: CGFloat, _ cpy2: CGFloat, _ x2: CGFloat, _ y2: CGFloat) {
        let g = self.contextComponents.context()
        setGraphicsConfiguration(context: g)

        drawing(mode: .fillStroke) {
            g?.move(to: CGPoint(x: x1, y: y1))
            g?.addCurve(to: CGPoint(x: x2, y: y2), control1: CGPoint(x: cpx1, y: cpy1), control2: CGPoint(x: cpx2, y: cpy2))
        }
    }

    public func radians(_ degrees: CGFloat) -> CGFloat {
        let radian = (CGFloat.pi * 2) * (degrees / 360.0)
        return radian
    }

    // For testing
    static func convertCurvePoint(_ cpx1: CGFloat, _ cpy1: CGFloat, _ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat, _ cpx2: CGFloat, _ cpy2: CGFloat) -> (CGPoint, CGPoint) {
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

        return (b1, b2)
    }

    private func setGraphicsConfiguration(context: CGContext?) {
        context?.setFillColor(self.colorComponents.fill.cgColor)
        context?.setStrokeColor(self.colorComponents.stroke.cgColor)
        context?.setLineWidth(self.colorComponents.strokeWeight)
    }

    private func drawing(mode: CGPathDrawingMode, closure:() -> Void) {
        let g = self.contextComponents.context()
        g?.saveGState()
        closure()

        // do not execute this line when testing to protect path infomation
        if !isTesting() {
            g?.drawPath(using: mode)
        }

        g?.restoreGState()
    }

    private func isTesting() -> Bool {
        return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    }
}
