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

    mutating func fill(_ color: UIColor)
    mutating func stroke(_ color: UIColor)
    mutating func strokeWeight(_ weight: CGFloat)
    mutating func noFill()
    mutating func noStroke()
}

struct ColorModel: ColorModelContractor {
    private var processingView: ProcessingView
    private var colorComponents: ColorComponents

    init(processingView: ProcessingView, colorComponents: ColorComponents) {
        self.processingView = processingView
        self.colorComponents = colorComponents
    }

    func background(_ color: UIColor) {
        let g = UIGraphicsGetCurrentContext()
        g!.clear(self.processingView.bounds)
        self.processingView.backgroundColor = color
    }

    func clear() {
        let g = UIGraphicsGetCurrentContext()
        g!.clear(self.processingView.bounds)
        self.background(UIColor.white)
    }

    mutating func fill(_ color: UIColor) {
        self.colorComponents.fill = color
    }

    mutating func stroke(_ color: UIColor) {
        self.colorComponents.stroke = color
    }

    mutating func strokeWeight(_ weight: CGFloat) {
        self.colorComponents.strokeWeight = weight
    }

    mutating func noFill() {
        self.colorComponents.fill = UIColor.clear
    }

    mutating func noStroke() {
        self.colorComponents.stroke = UIColor.clear
    }
}

extension ProcessingView: ColorModelContractor {
    public func background(_ color: UIColor) {
        self.colorModel.background(color)
    }

    public func clear() {
        self.colorModel.clear()
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
