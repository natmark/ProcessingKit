//
//  ProcessingView3D+Loop.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2019/03/24.
//  Copyright © 2019 Atsuya Sato. All rights reserved.
//
import Foundation

extension ProcessingView3D: LoopModelContract {
    public func loop() {
        self.timer?.fire()
    }

    public func noLoop() {
        self.timer?.invalidate()
        self.timer = nil
    }
}
