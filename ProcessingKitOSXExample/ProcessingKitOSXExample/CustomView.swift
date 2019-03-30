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
    func draw() {
        background(NSColor.white)
        fill(NSColor.blue)
        ellipse(mouseX, mouseY, 100, 100)
    }
}
