//
//  Frame.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2017/08/13.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation

class FrameComponents {
    var bounds: CGRect = CGRect.zero
    var frame: CGRect = CGRect.zero
    var frameRate: CGFloat = 60.0
}

protocol FrameModelContract {
    var width: CGFloat { get }
    var height: CGFloat { get }
    var frameRate: CGFloat { get }
    func frameRate(_ fps: CGFloat)
}

struct FrameModel: FrameModelContract {
    private var frameComponents: FrameComponents
    private var timer: Timer?

    init(frameComponents: FrameComponents, timer: Timer?) {
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

    func frameRate(_ fps: CGFloat) {
        self.frameComponents.frameRate = fps
    }
}

// MARK: - ProcessingView Public APIs
extension ProcessingView: FrameModelContract {
    public var frameRate: CGFloat {
        return self.frameModel.frameRate
    }

    public var width: CGFloat {
        return self.frameModel.width
    }

    public var height: CGFloat {
        return self.frameModel.height
    }

    public func frameRate(_ fps: CGFloat) {
        self.frameModel.frameRate(fps)

        self.timer?.invalidate()
        self.timer = nil
        self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(1.0 / fps), target: self, selector: #selector(update(timer:)), userInfo: nil, repeats: true)
    }

    @objc private func update(timer: Timer) {
        self.draw(self.frame)
    }
}
