//
//  CustomView.swift
//  ProcessingKitExample
//
//  Created by AtsuyaSato on 2017/08/05.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation
import ProcessingKit

class Ripple {
    var x: CGFloat = 0.0
    var y: CGFloat = 0.0
    var size: CGFloat = 0.0
    init(x: CGFloat, y: CGFloat, size: CGFloat) {
        self.x = x
        self.y = y
        self.size = size
    }
}
class Ball {
    var x: CGFloat = 0.0
    var y: CGFloat = 0.0
    var size: CGFloat = 0.0
    var speed: CGFloat = 0
    init(x: CGFloat, y: CGFloat, size: CGFloat, speed: CGFloat) {
        self.x = x
        self.y = y
        self.size = size
        self.speed = speed
    }

}

class CustomView : ProcessingView, ProcessingViewDelegate {
    
    var ripples: [Ripple] = []
    var balls: [Ball] = []
    
    func setup() {
        for _ in 0 ..< 30 {
            balls.append(Ball(x: CGFloat(arc4random() % UInt32(width)), y: -CGFloat(arc4random() % 500), size: 10 + CGFloat(arc4random() % 40), speed: 3 + CGFloat(arc4random() % 10)))
        }
    }

    func draw(){
        background(UIColor.white)
        
        noStroke()
        fill(UIColor(red: 0.2, green: 0.2, blue: 0.8, alpha: 1.0))
        for ball in balls {
            ball.y += ball.speed
            stroke(UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0))
            line(ball.x, ball.y - ball.size * 2, ball.x, ball.y)
            ellipse(ball.x, ball.y, ball.size, ball.size)
            if ball.y > height + 100 {
                ball.y = -CGFloat(arc4random() % 500)
            }
        }

        noFill()
        stroke(UIColor(red:1.0, green: 0.0, blue: 0.0, alpha: 1.0))
        strokeWeight(1.0)

        for ripple in ripples {
            ripple.size = ripple.size + 5
            ellipse(ripple.x, ripple.y, ripple.size, ripple.size)
        }
        ripples = ripples.filter { $0.size < 1_000 }
        
        fill(UIColor.black)
        textSize(20)
        text("Nodes: \(ripples.count + balls.count * 2)", 10, height - 30)
    }

    func fingerTapped() {
        let ripple = Ripple(x: touchX, y: touchY, size: 0)
        ripples.append(ripple)
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



