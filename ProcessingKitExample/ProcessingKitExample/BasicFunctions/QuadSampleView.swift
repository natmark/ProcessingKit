//
//  QuadSampleView.swift
//  ProcessingKitExample
//
//  Created by AtsuyaSato on 2017/12/29.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import UIKit
import ProcessingKit

class QuadSampleView : ProcessingView {
    func setup() {
        background(UIColor.white)
        fill(UIColor.red)
        strokeWeight(5.0)
        stroke(UIColor.blue)
        quad(30, 30, 20, 150, 200, 200, 400, 100)
    }
}
