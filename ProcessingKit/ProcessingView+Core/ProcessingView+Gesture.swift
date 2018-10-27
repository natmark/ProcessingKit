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

extension ProcessingView {
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
    @objc func didTap(recognizer: UITapGestureRecognizer) {
        self.gestureModel.didTap(recognizer: recognizer)

        let dispatchTime = DispatchTime.now() + Double(1.0 / self.frameRate)
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.didTapExit(recognizer: recognizer)
        }
    }
    func didTapExit(recognizer: UITapGestureRecognizer) {
        self.gestureModel.didTapExit(recognizer: recognizer)
    }
    @objc func didSwipe(recognizer: UISwipeGestureRecognizer) {
        self.gestureModel.didSwipe(recognizer: recognizer)
    }
    @objc func didPinch(recognizer: UIPinchGestureRecognizer) {
        self.gestureModel.didPinch(recognizer: recognizer)
    }
    @objc func didRotate(recognizer: UIRotationGestureRecognizer) {
        self.gestureModel.didRotate(recognizer: recognizer)
    }
    @objc func didPan(recognizer: UIPanGestureRecognizer) {
        self.gestureModel.didPan(recognizer: recognizer)
    }
    @objc func didLongPress(recognizer: UILongPressGestureRecognizer) {
        self.gestureModel.didLongPress(recognizer: recognizer)
    }
    #elseif os(OSX)
    @objc func didClick(recognizer: NSClickGestureRecognizer) {
        self.gestureModel.didClick(recognizer: recognizer)

        let dispatchTime = DispatchTime.now() + Double(1.0 / self.frameRate)
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.didClickExit(recognizer: recognizer)
        }
    }
    @objc func didClickExit(recognizer: NSClickGestureRecognizer) {
        self.gestureModel.didClickExit(recognizer: recognizer)
    }
    @objc func didMagnify(recognizer: NSMagnificationGestureRecognizer) {
        self.gestureModel.didMagnify(recognizer: recognizer)
    }
    @objc func didPan(recognizer: NSPanGestureRecognizer) {
        self.gestureModel.didPan(recognizer: recognizer)
    }
    @objc func didPress(recognizer: NSPressGestureRecognizer) {
        self.gestureModel.didPress(recognizer: recognizer)
    }
    @objc func didRotate(recognizer: NSRotationGestureRecognizer) {
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
