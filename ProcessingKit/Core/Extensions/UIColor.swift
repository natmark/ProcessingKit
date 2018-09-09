//
//  UIColor.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2017/08/16.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

#if os(iOS)
import UIKit
#elseif os(OSX)
import Cocoa
#endif

extension UIColor {
    class func hexStr (hexStr: NSString, alpha: CGFloat) -> UIColor {
        let alpha = alpha
        var hexStr = hexStr
        hexStr = hexStr.replacingOccurrences(of: "#", with: "") as NSString
        let scanner = Scanner(string: hexStr as String)
        var color: UInt32 = 0
        if scanner.scanHexInt32(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red: r, green: g, blue: b, alpha: alpha)
        } else {
            print("invalid hex string")
            return UIColor.white
        }
    }
}
