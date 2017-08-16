//
//  RectSampleView.swift
//  ProcessingKitExample
//
//  Created by AtsuyaSato on 2017/08/16.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import ProcessingKit

class RectSampleView : ProcessingView, ProcessingViewDelegate {
    func setup() {
        background(UIColor.white)
        fill(UIColor.red)
        rect(200, 100, 100, 100)
        fill(UIColor.blue)
        rect(250, 150, 100, 100)
        noFill()
        stroke(UIColor.black)
        rect(150, 200, 100, 100)
    }
}
