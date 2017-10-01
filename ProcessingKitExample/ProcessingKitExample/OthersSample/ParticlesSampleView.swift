//
//  ParticlesSampleView.swift
//  ProcessingKitExample
//
//  Created by AtsuyaSato on 2017/08/17.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import ProcessingKit

class ParticlesSampleView : ProcessingView {
    let totalDots = 50
    var dots: [Dot] = []
    let diameter: CGFloat = 12.0

    func setup() {
        // initial fill colour
        fill(UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0))
        noStroke();
        // array of dots
        for _ in 0..<totalDots {
            let d = Dot(width: width, height: height)
            d.x = CGFloat(arc4random() % UInt32(width))
            d.y = CGFloat(arc4random() % UInt32(height))
            d.vx = CGFloat(getRandomNumber(Min: 0.0, Max: 2.0) - Float(1.0))
            d.vy = CGFloat(getRandomNumber(Min: 0.0, Max: 2.0) - Float(1.0))
            dots.append(d)
        }

        background(UIColor.black)
    }
    func draw() {
        fill(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 25 / 255.0))
        rect(0, 0, width, height)

        var r: CGFloat = 255
        var g: CGFloat = 255
        let b: CGFloat = 255

        for dot in dots {
            r = (dot.x / width) * 255
            g = (dot.y / height) * 255
            fill(UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0))
            dot.update()
            ellipse(dot.x, dot.y, diameter, diameter)
        }
    }
    private func getRandomNumber(Min _Min : Float, Max _Max : Float)->Float {
        return ( Float(arc4random_uniform(UINT32_MAX)) / Float(UINT32_MAX) ) * (_Max - _Min) + _Min
    }
}

class Dot {
    var x: CGFloat = 0.0
    var y: CGFloat = 0.0
    var vx: CGFloat = 0.0
    var vy: CGFloat = 0.0
    var width: CGFloat = 0.0
    var height: CGFloat = 0.0

    init(width: CGFloat, height: CGFloat){
        self.width = width
        self.height = height
    }
    func update(){
        // update the velocity
        self.vx = self.vx + CGFloat(getRandomNumber(Min: 0.0, Max: 2.0) - 1.0)
        self.vx = self.vx * 0.96
        self.vy = self.vy + CGFloat(getRandomNumber(Min: 0.0, Max: 2.0) - 1.0)
        self.vy = self.vy * 0.96
        // update the position
        self.x = self.x + self.vx
        self.y = self.y + self.vy
        // handle boundary collision
        if (self.x > self.width) { self.x = self.width; self.vx = self.vx * -1.0 }
        if (self.x < 0) { self.x = 0; self.vx = self.vx * -1.0 }
        if (self.y > self.height) { self.y = self.height; self.vy = self.vy * -1.0 }
        if (self.y < 0) { self.y = 0; self.vy = self.vy * -1.0 }
    }
    private func getRandomNumber(Min _Min : Float, Max _Max : Float)->Float {
        return ( Float(arc4random_uniform(UINT32_MAX)) / Float(UINT32_MAX) ) * (_Max - _Min) + _Min
    }
}
