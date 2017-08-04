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

open class PxView : SKView {
    fileprivate var fill_ = UIColor.white
    fileprivate var stroke_ = UIColor.white
    fileprivate var strokeWeight_: CGFloat = 1.0

    public var pxViewDelegate : PxViewDelegate? = nil
    lazy fileprivate var pxScene : SKScene = {
        let pxScene = SKScene(size: self.frame.size)
        pxScene.scaleMode = SKSceneScaleMode.aspectFit
        pxScene.delegate = self
        return pxScene
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        prepareScene()
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareScene()
    }
    private func prepareScene(){
        self.presentScene(pxScene)
    }
    public func setup(delegate : PxViewDelegate){
        pxViewDelegate = delegate
        pxViewDelegate?.setup()
        self.showsFPS = true
        self.showsNodeCount = true
    }
}
// udpate
extension PxView: SKSceneDelegate {
    public func update(_ currentTime: TimeInterval, for scene: SKScene) {
        pxViewDelegate?.draw()
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
    public func rect(x:CGFloat, y:CGFloat, width:CGFloat, height:CGFloat){
        let position = self.convert(CGPoint(x: x , y: y + height), from: pxScene)

        let square = SKShapeNode(rect: CGRect(x: position.x, y: position.y, width: width, height: height))
        square.fillColor = fill_
        square.strokeColor = stroke_
        square.lineWidth = strokeWeight_
        pxScene.addChild(square)
    }
    public func ellipse(x:CGFloat, y:CGFloat, width:CGFloat, height:CGFloat){
        let circle = SKShapeNode(ellipseOf: CGSize(width: width, height: height))
        let position = self.convert(CGPoint(x: x, y: y), from: pxScene)
        circle.position = position
        circle.fillColor = fill_
        circle.strokeColor = stroke_
        circle.lineWidth = strokeWeight_
        pxScene.addChild(circle)
    }
    public func background(_ color: UIColor){
        pxScene.backgroundColor = color
    }
}
