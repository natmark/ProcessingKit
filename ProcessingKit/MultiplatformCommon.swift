//
//  MultiplatformCommon.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2017/12/31.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

#if !os(iOS)
import Cocoa
public typealias UIColor = NSColor
public typealias UIImageView = NSImageView
public typealias UIImage = NSImage
public typealias UIViewController = NSViewController
public typealias UITouch = NSTouch
public typealias UIFont = NSFont
public typealias UIEvent = NSEvent
public typealias UIView = NSView
public typealias UIResponder = NSResponder
#endif

import Foundation

public class MultiplatformCommon {
    public class func getCurrentContext() -> CGContext? {
        #if os(iOS)
            return UIGraphicsGetCurrentContext()
        #else
            return NSGraphicsContext.current()?.cgContext
        #endif
    }
}
