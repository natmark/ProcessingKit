//
//  Frame.swift
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

public protocol FrameComponentsContract {
    var bounds: CGRect { get set }
    var frame: CGRect { get set }
    var frameRate: CGFloat { get set }
    var frameCount: UInt64 { get set }
}

public protocol FrameModelContract {
    var width: CGFloat { get }
    var height: CGFloat { get }
    var frameRate: CGFloat { get }
    mutating func frameRate(_ fps: CGFloat)
}

public class FrameComponents: FrameComponentsContract {
    public var bounds: CGRect = CGRect.zero
    public var frame: CGRect = CGRect.zero
    public var frameRate: CGFloat = 60.0
    public var frameCount: UInt64 = 0

    public init() {}
}

public struct FrameModel: FrameModelContract {
    private var frameComponents: FrameComponentsContract
    private var timer: Timer?

    public init(frameComponents: FrameComponentsContract, timer: Timer?) {
        self.frameComponents = frameComponents
        self.timer = timer
    }

    public var width: CGFloat {
        return self.frameComponents.bounds.size.width
    }

    public var height: CGFloat {
        return self.frameComponents.bounds.size.height
    }

    public var frameRate: CGFloat {
        return self.frameComponents.frameRate
    }

    public mutating func frameRate(_ fps: CGFloat) {
        self.frameComponents.frameRate = fps
    }
}
