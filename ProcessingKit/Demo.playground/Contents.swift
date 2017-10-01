//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport
import ProcessingKit

//: Step 1: Create custom view class for drawing
class SampleView: ProcessingView, ProcessingViewDelegate {
    var i: CGFloat = 0
    var dx: CGFloat = 0

    //: The setup() function is run once, when the program starts.
    func setup() {
        dx = 10
    }

    //: Called directly after setup(), the draw() function continuously executes the lines of code contained inside its block until the program is stopped or noLoop() is called.
    func draw() {
        background(UIColor.white)
        fill(UIColor.red)
        ellipse(i, 100, 100, 100)
        i+=dx
        if i > width {
            i = 0
        }
    }
}

//: Step 2: Create custom view instance
let sampleView = SampleView(frame: CGRect(x: 0, y: 0, width: 360, height: 480))

//: Option for playground
sampleView.isPlayground = true

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = sampleView
