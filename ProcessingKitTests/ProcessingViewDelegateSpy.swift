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
    private let exceptions: XCTestExpectation
    private(set) var spyHistory: [Any] = []

    init(exceptions: XCTestExpectation) {
        self.exceptions = exceptions
    }

    func setup() {
        self.record(())
        exceptions.fulfill()
    }

    private func record(_ args: Void) {
        self.spyHistory += [args]
    }
}

class ProcessingViewDelegateDrawSpy: ProcessingViewDelegate {
    private let exceptions: XCTestExpectation
    private(set) var spyHistory: [Any] = []

    init(exceptions: XCTestExpectation) {
        self.exceptions = exceptions
    }

    func setup() {
        self.record(())
    }

    func draw() {
        self.record(())
        exceptions.fulfill()
    }
    private func record(_ args: Void) {
        self.spyHistory += [args]
    }
}
