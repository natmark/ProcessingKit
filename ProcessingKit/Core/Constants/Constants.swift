//
//  Constants.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2017/08/13.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation

#if os(iOS)
import UIKit
#elseif os(OSX)
import Cocoa
#endif

public protocol Constants {
    var HALF_PI: CGFloat { get }
    var PI: CGFloat { get }
    var QUARTER_PI: CGFloat { get }
    var TAU: CGFloat { get }
    var TWO_PI: CGFloat { get }
}
