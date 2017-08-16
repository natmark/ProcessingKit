//
//  Color.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2017/08/13.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation

struct ColorComponents {
    var fill_: UIColor = UIColor.white
    var stroke_: UIColor = UIColor.clear
    var strokeWeight_: CGFloat = 1.0
}

public protocol Color {
    func background(_ color: UIColor)
    func clear()

    func fill(_ color: UIColor)
    func stroke(_ color: UIColor)
    func strokeWeight(_ weight: CGFloat)
    func noFill()
    func noStroke()
}

extension ProcessingView: Color {
    public func background(_ color: UIColor) {
        let g = UIGraphicsGetCurrentContext()
        g!.clear(self.bounds)
        self.backgroundColor = color
    }
    public func clear() {
        let g = UIGraphicsGetCurrentContext()
        g!.clear(self.bounds)
        self.background(UIColor.white)
    }
    public func fill(_ color: UIColor) {
        self.colorComponents.fill_ = color
    }

    public func stroke(_ color: UIColor) {
        self.colorComponents.stroke_ = color
    }

    public func strokeWeight(_ weight: CGFloat) {
        self.colorComponents.strokeWeight_ = weight
    }

    public func noFill() {
        self.colorComponents.fill_ = UIColor.clear
    }

    public func noStroke() {
        self.colorComponents.stroke_ = UIColor.clear
    }
}
