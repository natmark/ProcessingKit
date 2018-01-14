//
//  TransformTests.swift
//  ProcessingKitTests
//
//  Created by AtsuyaSato on 2018/01/14.
//  Copyright © 2018年 Atsuya Sato. All rights reserved.
//

import XCTest
@testable import ProcessingKit

/* Quartz 2D
 https://developer.apple.com/library/content/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_affine/dq_affine.html

                       | a  b  0 |
 [x' y' 1] = [x y 1] × | c  d  0 |
                       | tx ty 1 |
 */

class ProcessingViewDelegateTranslateSpy: ProcessingViewDelegate {
    private let exception: XCTestExpectation
    private let view: ProcessingView
    private let x: CGFloat
    private let y: CGFloat
    private(set) var context: CGContext?

    init(exception: XCTestExpectation, view: ProcessingView, x: CGFloat, y: CGFloat) {
        self.exception = exception
        self.view = view
        self.x = x
        self.y = y
    }

    func setup() {
        self.view.translate(x, y)
        self.record(view.context)
        exception.fulfill()
    }

    private func record(_ arg: CGContext?) {
        self.context = arg
    }
}

class TransformTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testTranslate() {
        let view = ProcessingView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let translateDelegateSpy = ProcessingViewDelegateTranslateSpy(
            exception: expectation(description: "Point"),
            view: view,
            x: 100,
            y: 0
        )
        view.delegate = translateDelegateSpy
        waitForExpectations(timeout: 100)

        let expect = CGAffineTransform(a: 1.0, b: 0.0, c: -0.0, d: -1.0, tx: 100.0, ty: 100.0)
        let result = translateDelegateSpy.context?.ctm
        XCTAssertEqual(expect, result)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
