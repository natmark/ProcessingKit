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
        fill(NSColor.blue)
        ellipse(50, 50, 100, 100)
    }
//    var x: CGFloat = 0
//    func draw() {
//        background(NSColor.white)
//        print(x)
//        if x < 300 {
//            x += 1
//        }else{
//            x = 0
//        }
//
//        fill(NSColor.blue)
//        ellipse(x, 50, 100, 100)
//    }
}
