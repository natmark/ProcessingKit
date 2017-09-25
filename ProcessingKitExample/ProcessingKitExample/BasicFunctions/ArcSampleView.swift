//
//  ArcSampleView.swift
//  ProcessingKitExample
//
//  Created by AtsuyaSato on 2017/09/26.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import ProcessingKit

class ArcSampleView : ProcessingView, ProcessingViewDelegate {
    func setup() {
        background(UIColor.white)
        fill(UIColor.red)
        strokeWeight(5.0)
        stroke(UIColor.blue)
        arc(200, 200, 100, radians(0), radians(90.0))
    }
}

