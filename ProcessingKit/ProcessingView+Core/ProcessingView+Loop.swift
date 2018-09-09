//
//  ProcessingView+Loop.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2018/09/09.
//  Copyright © 2018年 Atsuya Sato. All rights reserved.
//

import Foundation

#if os(iOS)
import UIKit
#elseif os(OSX)
import Cocoa
#endif

extension ProcessingView: LoopModelContract {
    public func loop() {
        self.timer?.fire()
    }

    public func noLoop() {
        self.timer?.invalidate()
        self.timer = nil
    }
}
