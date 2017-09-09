//
//  Frame.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2017/08/13.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation

class FrameComponents {
    var frameRate: CGFloat = 60.0
}

protocol FrameModelContractor {
    var frameRate: CGFloat { get }
    mutating func frameRate(_ fps: CGFloat)
}

struct FrameModel: FrameModelContractor {
    var frameRate: CGFloat {
        return self.frameComponents.frameRate
    }

    private var frameComponents: FrameComponents
    private var timer: Timer?

    init(frameComponents: FrameComponents, timer: Timer?) {
        self.frameComponents = frameComponents
        self.timer = timer
    }

    mutating func frameRate(_ fps: CGFloat) {
        self.frameComponents.frameRate = fps
    }
}

extension ProcessingView: FrameModelContractor {
    public var frameRate: CGFloat {
        return self.frameModel.frameRate
    }

    public var width: CGFloat {
        return self.frame.size.width
    }

    public var height: CGFloat {
        return  self.frame.size.height
    }
}
