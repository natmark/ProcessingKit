//
//  Frame.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2017/08/13.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation

struct FrameComponents {
    var frameRate_: CGFloat = 60.0
}

public protocol Frame {
    func frameRate(_ fps: CGFloat)
    var frameRate: CGFloat { get }
    var width: CGFloat { get }
    var height: CGFloat { get }
}

extension PxView: Frame {
    public func frameRate(_ fps: CGFloat) {
        frameComponents.frameRate_ = fps
        timer?.invalidate()
        timer = nil
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(1.0 / frameComponents.frameRate_), target: self, selector: #selector(update(timer:)), userInfo: nil, repeats: true)
    }

    public var frameRate: CGFloat {
        return frameComponents.frameRate_
    }

    public var width: CGFloat {
        return self.frame.size.width
    }

    public var height: CGFloat {
        return self.frame.size.height
    }
}
