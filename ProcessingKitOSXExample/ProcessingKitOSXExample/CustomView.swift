//
//  CustomView.swift
//  ProcessingKitOSXExample
//
//  Created by AtsuyaSato on 2017/12/31.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation
import ProcessingKit
import Cocoa

class CustomView: ProcessingView {
    func setup() {
        background(NSColor.white)
    }

    var x: CGFloat = 0

    func draw() {
        background(NSColor.white)
        x += 2
        if x > width {
            x = 0
        }
        fill(NSColor.blue)
        ellipse(x, 0, 100, 100)
    }
}
