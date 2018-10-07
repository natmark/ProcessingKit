//
//  ProcessingView+Gesture.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2018/10/07.
//  Copyright © 2018 Atsuya Sato. All rights reserved.
//

import Foundation

#if os(iOS)
import UIKit
#elseif os(OSX)
import Cocoa
#endif

extension ProcessingView: GestureModelContract {
    #if os(iOS)
    public var fingerPressed: Bool {
        return self.gestureModel.fingerPressed
    }

    public var touchX: CGFloat {
        return self.gestureModel.touchX
    }

    public var touchY: CGFloat {
        return self.gestureModel.touchY
    }

    public var touches: Set<CGPoint> {
        return self.gestureModel.touches
    }
    #elseif os(OSX)
    public var mousePressed: Bool {
        return self.gestureModel.mousePressed
    }

    public var mouseX: CGFloat {
        return self.gestureModel.mouseX
    }

    public var mouseY: CGFloat {
        return self.gestureModel.mouseY
    }
    #endif

    #if os(iOS)
    public func touchesBegan(_ touches: Set<CGPoint>) {
        self.gestureModel.touchesBegan(touches)
    }

    public func touchesMoved(_ touches: Set<CGPoint>) {
        self.gestureModel.touchesMoved(touches)
    }

    public func touchesEnded(_ touches: Set<CGPoint>) {
        self.gestureModel.touchesEnded(touches)
    }

    @objc public func didTap(recognizer: UITapGestureRecognizer) {
        self.gestureModel.didTap(recognizer: recognizer)

        let dispatchTime = DispatchTime.now() + Double(1.0 / self.frameRate)
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.didTapExit(recognizer: recognizer)
        }
    }
    public func didTapExit(recognizer: UITapGestureRecognizer) {
        self.gestureModel.didTapExit(recognizer: recognizer)
    }
    @objc public func didSwipe(recognizer: UISwipeGestureRecognizer) {
        self.gestureModel.didSwipe(recognizer: recognizer)
    }
    @objc public func didPinch(recognizer: UIPinchGestureRecognizer) {
        self.gestureModel.didPinch(recognizer: recognizer)
    }
    @objc public func didRotate(recognizer: UIRotationGestureRecognizer) {
        self.gestureModel.didRotate(recognizer: recognizer)
    }
    @objc public func didPan(recognizer: UIPanGestureRecognizer) {
        self.gestureModel.didPan(recognizer: recognizer)
    }
    @objc public func didLongPress(recognizer: UILongPressGestureRecognizer) {
        self.gestureModel.didLongPress(recognizer: recognizer)
    }
    #elseif os(OSX)
    public func mouseDown(_ location: NSPoint) {
        self.gestureModel.mouseDown(location)
    }
    public func mouseDragged(_ location: NSPoint) {
        self.gestureModel.mouseDragged(location)
    }
    public func mouseUp(_ location: NSPoint) {
        self.gestureModel.mouseUp(location)
    }
    public func mouseMoved(_ location: NSPoint) {
        self.gestureModel.mouseMoved(location)
    }
    @objc public func didClick(recognizer: NSClickGestureRecognizer) {
        self.gestureModel.didClick(recognizer: recognizer)

        let dispatchTime = DispatchTime.now() + Double(1.0 / self.frameRate)
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.didClickExit(recognizer: recognizer)
        }
    }
    @objc public func didClickExit(recognizer: NSClickGestureRecognizer) {
        self.gestureModel.didClickExit(recognizer: recognizer)
    }
    @objc public func didMagnify(recognizer: NSMagnificationGestureRecognizer) {
        self.gestureModel.didMagnify(recognizer: recognizer)
    }
    @objc public func didPan(recognizer: NSPanGestureRecognizer) {
        self.gestureModel.didPan(recognizer: recognizer)
    }
    @objc public func didPress(recognizer: NSPressGestureRecognizer) {
        self.gestureModel.didPress(recognizer: recognizer)
    }
    @objc public func didRotate(recognizer: NSRotationGestureRecognizer) {
        self.gestureModel.didRotate(recognizer: recognizer)
    }
    open override func scrollWheel(with event: NSEvent) {
        self.gestureModel.scrollWheel(with: event)
    }
    open override func mouseMoved(with event: NSEvent) {
        self.gestureModel.mouseMoved(with: event)
    }
    #endif
}
