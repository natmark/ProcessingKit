//
//  ProcessingViewContract.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2019/03/24.
//  Copyright © 2019 Atsuya Sato. All rights reserved.
//

import UIKit

@objc public protocol ProcessingViewDelegate {
    @objc optional func setup()
    @objc optional func draw()
}

@objc public protocol ProcessingViewGestureDelegate {
    #if os(iOS)
    @objc optional func didTap()
    @objc optional func didRelease()
    @objc optional func didDrag() //Pan
    @objc optional func didSwipe(direction: UISwipeGestureRecognizer.Direction)
    @objc optional func didPinch(scale: CGFloat, velocity: CGFloat)
    @objc optional func didRotate(rotation: CGFloat, velocity: CGFloat)
    @objc optional func didLongPress()
    #elseif os(OSX)
    @objc optional func didClick()
    @objc optional func didRelease()
    @objc optional func didDrag()
    @objc optional func didMove()
    @objc optional func didMagnify(magnification: CGFloat)
    @objc optional func didRotate(rotation: CGFloat, inDegrees: CGFloat)
    @objc optional func didPress()
    @objc optional func didScroll(x: CGFloat, y: CGFloat)
    #endif
}
