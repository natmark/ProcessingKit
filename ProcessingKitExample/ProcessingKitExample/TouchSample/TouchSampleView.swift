//
//  TouchSampleView.swift
//  ProcessingKitExample
//
//  Created by AtsuyaSato on 2017/08/05.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import ProcessingKit

class TouchSampleView : ProcessingView, ProcessingViewDelegate {
    func setup() {
        background(UIColor.white)
        textAlign(.center)
        textSize(20.0)
        stroke(UIColor.black)
        fill(UIColor.black)
        text("Touch me!", self.frame.size.width / 2, self.frame.size.height / 2)

        noStroke()
        fill(UIColor.red)
    }
    func draw() {
        if fingerPressed {
            ellipse(touchX, touchY, 30, 30)
        }
    }
}
