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

protocol ColorModelContractor {
    func background(_ color: UIColor)
    func clear()
    func fill(_ color: UIColor)
    func stroke(_ color: UIColor)
    func strokeWeight(_ weight: CGFloat)
    func noFill()
    func noStroke()
}

struct ColorModel: ColorModelContractor {
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

    func clear() {
        let g = UIGraphicsGetCurrentContext()
        g!.clear(self.frameComponents.bounds)
    }

    func fill(_ color: UIColor) {
        self.colorComponents.fill = color
    }

    func stroke(_ color: UIColor) {
        self.colorComponents.stroke = color
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
extension ProcessingView: ColorModelContractor {
    public func background(_ color: UIColor) {
        self.colorModel.background(color)
        self.backgroundColor = color
    }

    public func clear() {
        self.colorModel.clear()
        self.background(UIColor.white)
    }

    public func fill(_ color: UIColor) {
        self.colorModel.fill(color)
    }

    public func stroke(_ color: UIColor) {
        self.colorModel.stroke(color)
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
