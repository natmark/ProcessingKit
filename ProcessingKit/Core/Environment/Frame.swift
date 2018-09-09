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

class FrameComponents: FrameComponentsContract {
    var bounds: CGRect = CGRect.zero
    var frame: CGRect = CGRect.zero
    var frameRate: CGFloat = 60.0
    var frameCount: UInt64 = 0
}

public protocol FrameModelContract {
    var width: CGFloat { get }
    var height: CGFloat { get }
    var frameRate: CGFloat { get }
    mutating func frameRate(_ fps: CGFloat)
}

struct FrameModel: FrameModelContract {
    private var frameComponents: FrameComponentsContract
    private var timer: Timer?

    init(frameComponents: FrameComponentsContract, timer: Timer?) {
        self.frameComponents = frameComponents
        self.timer = timer
    }

    var width: CGFloat {
        return self.frameComponents.bounds.size.width
    }

    var height: CGFloat {
        return self.frameComponents.bounds.size.height
    }

    var frameRate: CGFloat {
        return self.frameComponents.frameRate
    }

    mutating func frameRate(_ fps: CGFloat) {
        self.frameComponents.frameRate = fps
    }
}
