//
//  Color.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2017/08/13.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation

#if os(iOS)
import UIKit
#elseif os(OSX)
import Cocoa
#endif

public protocol ColorComponentsContract {
    var fill: UIColor { get set }
    var stroke: UIColor { get set }
    var strokeWeight: CGFloat { get set }
}

public protocol ColorModelContract {
    func background(_ color: UIColor)
    func background(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat)
    func clear()
    mutating func fill(_ color: UIColor)
    mutating func fill(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat)
    mutating func stroke(_ color: UIColor)
    mutating func stroke(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat)
    mutating func strokeWeight(_ weight: CGFloat)
    mutating func noFill()
    mutating func noStroke()
}

public class ColorComponents: ColorComponentsContract {
    public var fill: UIColor = UIColor.white
    public var stroke: UIColor = UIColor.clear
    public var strokeWeight: CGFloat = 1.0
}

public struct ColorModel: ColorModelContract {
    private var contextComponents: ContextComponenetsContract
    private var colorComponents: ColorComponentsContract
    private var frameComponents: FrameComponentsContract

    public init(contextComponents: ContextComponenetsContract, colorComponents: ColorComponentsContract, frameComponents: FrameComponentsContract) {
        self.contextComponents = contextComponents
        self.colorComponents = colorComponents
        self.frameComponents = frameComponents
    }

    public func background(_ color: UIColor) {
        let g = self.contextComponents.context()
        g?.clear(self.frameComponents.bounds)
    }

    public func background(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) {
        self.background(UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a / 255.0))
    }

    public func clear() {
        let g = self.contextComponents.context()
        g?.clear(self.frameComponents.bounds)
    }

    public mutating func fill(_ color: UIColor) {
        self.colorComponents.fill = color
    }

    public mutating func fill(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) {
        self.fill(UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a / 255.0))
    }

    public mutating func stroke(_ color: UIColor) {
        self.colorComponents.stroke = color
    }

    public mutating func stroke(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) {
        self.stroke(UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a / 255.0))
    }

    public mutating func strokeWeight(_ weight: CGFloat) {
        self.colorComponents.strokeWeight = weight
    }

    public mutating func noFill() {
        self.colorComponents.fill = UIColor.clear
    }

    public mutating func noStroke() {
        self.colorComponents.stroke = UIColor.clear
    }
}
