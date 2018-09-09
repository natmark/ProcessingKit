//
//  ProcessingView+Event.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2018/09/09.
//  Copyright © 2018年 Atsuya Sato. All rights reserved.
//

import Foundation

#if os(iOS)
import UIKit
import ProcessingKitCore
#elseif os(OSX)
import Cocoa
import ProcessingKitCoreOSX
#endif

extension ProcessingView: EventModelContract {
    #if os(iOS)
    public var fingerPressed: Bool {
        return self.eventModel.fingerPressed
    }

    public var touchX: CGFloat {
        return self.eventModel.touchX
    }

    public var touchY: CGFloat {
        return self.eventModel.touchY
    }

    public var touchesX: Set<CGFloat> {
        return self.eventModel.touchesX
    }

    public var touchesY: Set<CGFloat> {
        return self.eventModel.touchesY
    }
    #elseif os(OSX)
    public var mousePressed: Bool {
        return self.eventModel.mousePressed
    }

    public var mouseX: CGFloat {
        return self.eventModel.mouseX
    }

    public var mouseY: CGFloat {
        return self.eventModel.mouseY
    }

    #endif

    #if os(iOS)
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.eventModel.touchesBegan(touches, with: event)
    }

    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.eventModel.touchesMoved(touches, with: event)
    }

    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.eventModel.touchesEnded(touches, with: event)
    }
    #elseif os(OSX)
    open override func mouseDown(with event: NSEvent) {
        self.eventModel.mouseDown(with: event)
    }

    open override func mouseDragged(with event: NSEvent) {
        self.eventModel.mouseDragged(with: event)
    }

    open override func mouseUp(with event: NSEvent) {
        self.eventModel.mouseUp(with: event)
    }

    open override func mouseMoved(with event: NSEvent) {
        self.eventModel.mouseMoved(with: event)
    }
    #endif
}
