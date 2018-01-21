//
//  ProcessingViewDelegateSpy.swift
//  ProcessingKitTests
//
//  Created by AtsuyaSato on 2017/09/26.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import XCTest
@testable import ProcessingKit

class ProcessingViewDelegateSetupSpy: ProcessingViewDelegate {
    private let exception: XCTestExpectation
    private(set) var spyHistory: [Any] = []

    init(exception: XCTestExpectation) {
        self.exception = exception
    }

    func setup() {
        self.record(())
        exception.fulfill()
    }

    private func record(_ args: Void) {
        self.spyHistory += [args]
    }
}

class ProcessingViewDelegateDrawSpy: ProcessingViewDelegate {
    private let exception: XCTestExpectation
    private(set) var spyHistory: [Any] = []

    init(exception: XCTestExpectation) {
        self.exception = exception
    }

    func setup() {
        self.record(())
    }

    func draw() {
        self.record(())
        exception.fulfill()
    }
    private func record(_ args: Void) {
        self.spyHistory += [args]
    }
}
