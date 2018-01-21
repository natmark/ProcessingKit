//
//  ProcessingViewTests.swift
//  ProcessingViewTests
//
//  Created by AtsuyaSato on 2017/08/04.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import XCTest
@testable import ProcessingKit

class ProcessingViewTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testCallSetup() {
        let view = ProcessingView(frame: CGRect.zero)

        let processingViewDelegateSpy = ProcessingViewDelegateSetupSpy(exception:
            expectation(description: "Setup")
        )
        view.delegate = processingViewDelegateSpy
        waitForExpectations(timeout: 100)
        XCTAssertEqual(processingViewDelegateSpy.spyHistory.count, 1)
    }

    func testCallDraw() {
        let view = ProcessingView(frame: CGRect.zero)

        let processingViewDelegateSpy = ProcessingViewDelegateDrawSpy(exception:
            expectation(description: "Draw")
        )
        view.delegate = processingViewDelegateSpy
        waitForExpectations(timeout: 100)
        print(processingViewDelegateSpy.spyHistory.count)
        XCTAssertEqual(processingViewDelegateSpy.spyHistory.count, 2)
    }

}
