//
//  Structure.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2017/08/13.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation

protocol LoopModelContractor {
    func loop()
    func noLoop()
}

struct LoopModel: LoopModelContractor {
    private var timer: Timer?

    init(timer: Timer?) {
        self.timer = timer
    }

    func loop() {
        self.timer?.fire()
    }

    func noLoop() {
        self.timer?.invalidate()
    }
}

extension ProcessingView: LoopModelContractor {
    public func loop() {
        self.loopModel.loop()
    }

    public func noLoop() {
        self.loopModel.noLoop()
    }
}
