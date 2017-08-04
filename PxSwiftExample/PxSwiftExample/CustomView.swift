//
//  CustomView.swift
//  PxSwiftExample
//
//  Created by AtsuyaSato on 2017/08/05.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation
import PxSwift

class CustomView : PxView {
    public var x = 10;
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup(delegate: self)
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup(delegate: self)
    }
}
extension CustomView : PxViewDelegate {
    func setup() {
        print("setup")

        background(UIColor.darkGray)
        stroke(UIColor.white)
        rect(x: 200, y: 200, width: 100, height: 100)
        fill(UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.4))
        ellipse(x: 200, y: 200, width: 100, height: 100)
        noStroke()
        fill(UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.8))
        ellipse(x: 300, y: 300, width: 100, height: 100)
    }
    func draw(){
        x = x + 5
        rect(x: CGFloat(x), y: 200, width: 10, height: 10)
    }
}
