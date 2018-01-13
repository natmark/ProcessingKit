//
//  CurveSampleView.swift
//  ProcessingKitExample
//
//  Created by AtsuyaSato on 2017/12/30.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import UIKit
import ProcessingKit

class CurveSampleView : ProcessingView {
    func setup() {
        background(UIColor.white)
        stroke(UIColor.black)
        curve(40, 40, 80, 60, 100, 100, 60, 120)
        noStroke()
        fill(255, 0, 0)
        ellipse(40, 40, 3, 3)
        fill(0, 0, 255, 192)
        ellipse(100, 100, 3, 3)
        ellipse(80, 60, 3, 3)
        fill(255, 0, 0)
        ellipse(60, 120, 3, 3)
    }
}

