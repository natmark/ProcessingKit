//
//  DrawableView.swift
//  DrawableView
//
//  Created by AtsuyaSato on 2017/03/13.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import UIKit
import CoreGraphics
public enum NAPenMode {
    case pen
    case eraser
}
public class NADrawableView: UIImageView {
    private var previousTouchLocation: CGPoint?
    private var coalescedTouches : [UITouch]?
    public var penColor = UIColor.black
    public var penMode: NAPenMode = .pen

    public init() {
        super.init(frame: CGRect.zero)
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        previousTouchLocation = touches.first?.location(in: self)
    }
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        coalescedTouches = event?.coalescedTouches(for: touches.first!)
        draw(self.frame)
    }
    public override func draw(_ rect: CGRect) {
        guard let coalescedTouches = coalescedTouches else {
            return
        }
        UIGraphicsBeginImageContext(rect.size)
        self.image?.draw(at: CGPoint(x: 0, y: 0))

        let cgContext = UIGraphicsGetCurrentContext()
        cgContext?.setLineCap(CGLineCap.round)
        cgContext?.setStrokeColor(penColor.cgColor)

        switch penMode {
        case .pen:
            cgContext?.setBlendMode(.normal)
        case .eraser:
            cgContext?.setBlendMode(.clear)
        }

        for coalescedTouch in coalescedTouches {
            let lineWidth = coalescedTouch.force != 0 ?
                (coalescedTouch.force / coalescedTouch.maximumPossibleForce) * 10 :
            10
            cgContext?.setLineWidth(lineWidth)
            cgContext?.move(to: CGPoint(x: previousTouchLocation!.x, y: previousTouchLocation!.y))
            cgContext?.addLine(to: CGPoint(x: coalescedTouch.location(in: self).x, y: coalescedTouch.location(in: self).y))
            previousTouchLocation = coalescedTouch.location(in: self)
            cgContext?.strokePath()
        }
        let drawnImage = UIGraphicsGetImageFromCurrentImageContext()
        self.image = drawnImage
    }
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        previousTouchLocation = nil
    }
}
