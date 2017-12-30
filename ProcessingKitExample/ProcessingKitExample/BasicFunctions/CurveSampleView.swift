//
//  CurveSampleView.swift
//  ProcessingKitExample
//
//  Created by AtsuyaSato on 2017/12/30.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import ProcessingKit

class CurveSampleView : ProcessingView {
    func setup() {
        background(UIColor.white)
        fill(UIColor.red)
        strokeWeight(5.0)
        stroke(UIColor.blue)
        curve(0, 200, 50, 50, 200, 50, width, 200)
    }
}

