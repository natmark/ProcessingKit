//
//  ClockSampleView.swift
//  ProcessingKitExample
//
//  Created by AtsuyaSato on 2017/09/30.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import ProcessingKit

class ClockSampleView : ProcessingView {
    func setup() {
        stroke(UIColor.black)
    }

    func draw() {
        background(UIColor.white)
        let s = second()
        let m = minute()
        let h = hour() % 12
        translate(width/2, width/2)

        noFill()
        stroke(UIColor.black)

        // 秒針
        pushMatrix()
        rotate(radians(CGFloat(s)*(360/60)))
        strokeWeight(1)
        line(0, 0, 0, -width/2)
        popMatrix()

        // 分針
        pushMatrix()
        rotate(radians(CGFloat(m)*(360/60)))
        strokeWeight(2)
        line(0, 0, 0, -width/2)
        popMatrix()

        // 時針
        pushMatrix()
        rotate(radians(CGFloat(h)*(360/12)))
        strokeWeight(4)
        line(0, 0, 0, -width/3)
        popMatrix()

        strokeWeight(2);
        beginShape(.points);
        stride(from: 0, to: 360, by: 6).forEach {
            let angle = radians(CGFloat($0))
            let x = cos(angle) * width / 2
            let y = sin(angle) * width / 2
            vertex(x, y)
        }
        endShape()
    }
}
