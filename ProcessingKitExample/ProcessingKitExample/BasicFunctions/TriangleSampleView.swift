//
//  TriangleSampleView.swift
//  ProcessingKitExample
//
//  Created by AtsuyaSato on 2017/12/29.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import ProcessingKit

class TriangleSampleView : ProcessingView {
    func setup() {
        background(UIColor.white)
        fill(UIColor.red)
        strokeWeight(5.0)
        stroke(UIColor.blue)
        triangle(width/2, 100, 0, height/2, width, height/2)
    }
}
