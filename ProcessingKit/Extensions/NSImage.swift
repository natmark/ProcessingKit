//
//  NSImage.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2017/12/31.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation
import Cocoa

extension NSImage {
    var cgImage: CGImage? {
        var imageRect = NSRect(x: 0, y: 0, width: size.width, height: size.height)
        #if swift(>=3.0)
            guard let image =  cgImage(forProposedRect: &imageRect, context: nil, hints: nil) else {
                return nil
            }
        #else
            guard let image = CGImageForProposedRect(&imageRect, context: nil, hints: nil) else {
            return nil
            }
        #endif
        return image
    }
}
