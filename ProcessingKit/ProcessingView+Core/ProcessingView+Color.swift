//
//  ProcessingView+Color.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2018/09/09.
//  Copyright © 2018年 Atsuya Sato. All rights reserved.
//

import Foundation

#if os(iOS)
import UIKit
import ProcessingKitCore
#elseif os(OSX)
import Cocoa
import ProcessingKitCoreOSX
#endif

extension ProcessingView: ColorModelContract {
    public func background(_ color: UIColor) {
        self.colorModel.background(color)
        self.backgroundColor = color
    }

    public func background(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 255) {
        self.colorModel.background(r, g, b, a)
        self.backgroundColor = UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a / 255.0)

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
