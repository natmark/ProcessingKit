//
//  LineSampleView.swift
//  ProcessingKitExample
//
//  Created by AtsuyaSato on 2017/08/16.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import UIKit
import ProcessingKit

class TextSampleView : ProcessingView {
    func setup() {
        background(UIColor.white)
        fill(UIColor.black)
        textSize(64.0)
        textAlign(.center)
        text("Hello World", self.frame.size.width / 2, self.frame.size.height / 2)

        textFont(UIFont(name: "AmericanTypewriter", size: 40.0)!)
        fill(UIColor(red: 4 / 255.0, green: 39 / 255.0, blue: 69 / 255.0, alpha: 255.0 / 255.0))
        text("Processing Kit", self.frame.size.width / 2, self.frame.size.height / 2 + 50)
    }
}
