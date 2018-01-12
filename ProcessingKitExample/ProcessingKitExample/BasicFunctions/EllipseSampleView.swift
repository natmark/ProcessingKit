//
//  EllipseSampleView.swift
//  ProcessingKitExample
//
//  Created by AtsuyaSato on 2017/08/16.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import UIKit
import ProcessingKit

class EllipseSampleView : ProcessingView {
    func setup() {
        background(UIColor.white)
        fill(UIColor.red)
        ellipse(200, 100, 100, 100)
        fill(UIColor.blue)
        ellipse(250, 150, 100, 100)
        noFill()
        stroke(UIColor.black)
        ellipse(150, 200, 100, 100)
    }
}

