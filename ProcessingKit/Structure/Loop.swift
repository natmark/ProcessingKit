//
//  Structure.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2017/08/13.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation

protocol LoopModelContract {
    func loop()
    func noLoop()
}

// MARK: - ProcessingView Public APIs
extension ProcessingView: LoopModelContract {
    public func loop() {
        self.timer?.fire()
    }

    public func noLoop() {
        self.timer?.invalidate()
        self.timer = nil
    }
}
