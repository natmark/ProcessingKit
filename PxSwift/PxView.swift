//
//  PxView.swift
//  PxSwift
//
//  Created by AtsuyaSato on 2017/08/05.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation
import SpriteKit

public protocol PxViewDelegate {
    func setup()
    func draw()
}
open class PxView : UIView {
    fileprivate var fill_ = UIColor.white
    fileprivate var stroke_ = UIColor.white
    fileprivate var strokeWeight_: CGFloat = 1.0

    public var pxViewDelegate : PxViewDelegate? = nil
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public func setup(delegate : PxViewDelegate){
        pxViewDelegate = delegate
        _ = Timer.scheduledTimer(timeInterval: 1.0 / 60 , target: self, selector: #selector(update(timer:)), userInfo: nil, repeats: true)
    }
}
// udpate
extension PxView {
    public func update(timer: Timer){
        self.setNeedsDisplay()
    }
    fileprivate func setup(){
        fill_ = UIColor.white
        stroke_ = UIColor.white
        strokeWeight_ = 1.0
    }
}
// readonly properties
extension PxView {
    var width: CGFloat {
        get {
            return self.frame.size.width
        }
    }
    var height: CGFloat {
        get {
            return self.frame.size.height
        }
    }
}
// properties
extension PxView {
    public func fill(_ color: UIColor){
        fill_ = color
    }
    public func stroke(_ color: UIColor){
        stroke_ = color
    }
    public func strokeWeight(_ weight: CGFloat){
        strokeWeight_ = weight
    }
    public func noFill(){
        fill_ = UIColor.clear
    }
    public func noStroke(){
        stroke_ = UIColor.clear
        strokeWeight_ = 0.0
    }
}
// drawing functions
extension PxView {
    open override func draw(_ rect: CGRect) {
        setup()
        pxViewDelegate?.setup()
        pxViewDelegate?.draw()
    }
    public func rect(x:CGFloat, y:CGFloat, width:CGFloat, height:CGFloat){
        let g = UIGraphicsGetCurrentContext()
        g?.setFillColor(fill_.cgColor)
        g?.setStrokeColor(stroke_.cgColor)
        g?.setLineWidth(strokeWeight_)
        g?.stroke(CGRect(x: x, y: y, width: width, height: height))
        g?.fill(CGRect(x: x, y: y, width: width, height: height))
    }
    public func ellipse(x:CGFloat, y:CGFloat, width:CGFloat, height:CGFloat){
        let g = UIGraphicsGetCurrentContext()
        g?.setFillColor(fill_.cgColor)
        g?.setStrokeColor(stroke_.cgColor)
        g?.setLineWidth(strokeWeight_)

        g?.strokeEllipse(in: CGRect(x: x - width / 2, y: y - height / 2, width: width, height: height))
        g?.fillEllipse(in: CGRect(x: x - width / 2, y: y - height / 2, width: width, height: height))
    }
    public func background(_ color: UIColor){
        self.backgroundColor = color
    }
}
