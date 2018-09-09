//
//  NSView.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2017/12/31.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

#if os(OSX)
import Cocoa
#endif

extension NSView {
    var backgroundColor: NSColor? {
        get {
            guard let layer = layer, let backgroundColor = layer.backgroundColor else {return nil}
            return NSColor(cgColor: backgroundColor)
        }
        set {
            wantsLayer = true
            layer?.backgroundColor = newValue?.cgColor
        }
    }
}
