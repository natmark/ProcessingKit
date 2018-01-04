//
//  MultiplatformCommon.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2017/12/31.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation

#if os(iOS)
import UIKit
#elseif os(OSX)
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

public class MultiplatformCommon {
    public class func getCurrentContext() -> CGContext? {
        #if os(iOS)
            return UIGraphicsGetCurrentContext()
        #elseif os(OSX)
            return NSGraphicsContext.current?.cgContext
        #endif
    }
}
