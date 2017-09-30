//
//  Color.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2017/08/13.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation

class ColorComponents {
    var fill: UIColor = UIColor.white
    var stroke: UIColor = UIColor.clear
    var strokeWeight: CGFloat = 1.0
}

protocol ColorModelContract {
    func background(_ color: UIColor)
    func background(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat)
    func clear()
    func fill(_ color: UIColor)
    func fill(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat)
    func stroke(_ color: UIColor)
    func stroke(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat)
    func strokeWeight(_ weight: CGFloat)
    func noFill()
    func noStroke()
}

struct ColorModel: ColorModelContract {
    private var colorComponents: ColorComponents
    private var frameComponents: FrameComponents

    init(colorComponents: ColorComponents, frameComponents: FrameComponents) {
        self.colorComponents = colorComponents
        self.frameComponents = frameComponents
    }

    func background(_ color: UIColor) {
        let g = UIGraphicsGetCurrentContext()
        g!.clear(self.frameComponents.bounds)
    }

    func background(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) {
        self.background(UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a / 255.0))
    }

    func clear() {
        let g = UIGraphicsGetCurrentContext()
        g!.clear(self.frameComponents.bounds)
    }

    func fill(_ color: UIColor) {
        self.colorComponents.fill = color
    }

    func fill(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) {
        self.fill(UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a / 255.0))
    }

    func stroke(_ color: UIColor) {
        self.colorComponents.stroke = color
    }

    func stroke(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) {
        self.stroke(UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a / 255.0))
    }

    func strokeWeight(_ weight: CGFloat) {
        self.colorComponents.strokeWeight = weight
    }

    func noFill() {
        self.colorComponents.fill = UIColor.clear
    }

    func noStroke() {
        self.colorComponents.stroke = UIColor.clear
    }
}

// MARK: - ProcessingView Public APIs
extension ProcessingView: ColorModelContract {
    public func background(_ color: UIColor) {
        self.colorModel.background(color)
        self.backgroundColor = color
    }

    public func background(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 255) {
        self.colorModel.background(r, g, b, a)
    }

    public func clear() {
        self.colorModel.clear()
        self.background(UIColor.white)
    }

    public func fill(_ color: UIColor) {
        self.colorModel.fill(color)
    }

    public func fill(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 255) {
        self.colorModel.fill(r, g, b, a)
    }

    public func stroke(_ color: UIColor) {
        self.colorModel.stroke(color)
    }

    public func stroke(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 255) {
        self.colorModel.stroke(r, g, b, a)
    }

    public func strokeWeight(_ weight: CGFloat) {
        self.colorModel.strokeWeight(weight)
    }

    public func noFill() {
        self.colorModel.noFill()
    }

    public func noStroke() {
        self.colorModel.noStroke()
    }
}
