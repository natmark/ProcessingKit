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
        fill(UIColor.hexStr(hexStr: "#042745", alpha: 1.0))
        text("Processing Kit", self.frame.size.width / 2, self.frame.size.height / 2 + 50)
    }
}
