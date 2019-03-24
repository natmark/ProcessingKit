//
//  ProcessingView3D+Frame.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2019/03/24.
//  Copyright © 2019 Atsuya Sato. All rights reserved.
//

import Foundation

#if os(iOS)
import UIKit
#elseif os(OSX)
import Cocoa
#endif

extension ProcessingView3D: FrameModelContract {
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

    public func delay(napTime: Int) {
        let delayInSeconds = Double(napTime) / 1000.0
        self.timer?.invalidate()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            self.timer?.fire()
        }
    }

    @objc private func update(timer: Timer) {
        self.draw(self.frame)
    }
}
