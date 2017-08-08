//
//  CustomView.swift
//  PxSwiftExample
//
//  Created by AtsuyaSato on 2017/08/05.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation
import PxSwift

class CustomView : PxView, PxViewDelegate {
    var x = 0
    func setup() {
        print("setup")
        
        background(UIColor.darkGray)
        stroke(UIColor.white)
        rect(x: 200, y: 200, width: 100, height: 100)
        fill(UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.4))
        ellipse(x: 200, y: 200, width: 100, height: 100)
        rect(x: 100, y: 300, width: 100, height: 100)
        ellipse(x: 300, y: 400, width: 150, height: 100)
        noStroke()
        fill(UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0))
        ellipse(x: 300, y: 300, width: 100, height: 100)
        rect(x: 10, y: 10, width: 100, height: 100)
    }
    
    func draw(){
        print("draw")
        x += 1
        fill(UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0))
        ellipse(x: CGFloat(x), y: 300, width: 100, height: 100)
    }
    
    // Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = self
    }
    
}
