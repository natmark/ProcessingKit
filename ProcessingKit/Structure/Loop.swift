//
//  Structure.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2017/08/13.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation

public protocol Loop {
    func loop()
    func noLoop()
}

extension ProcessingView: Loop {
    public func loop() {
        self.timer?.fire()
    }

    public func noLoop() {
        self.timer?.invalidate()
    }
}
