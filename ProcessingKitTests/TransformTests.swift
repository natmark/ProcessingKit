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
        self.record(UIGraphicsGetCurrentContext())
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
        let testCases: [UInt: TestCase] = [
            #line: TestCase(
                description: "Move 100pt to the right",
                translate: (x: 100.0, y: 0.0),
                expect: CGAffineTransform(a: 1.0, b: 0.0, c: -0.0, d: -1.0, tx: 100.0, ty: 100.0)
            ),
            #line: TestCase(
                description: "Move 50pt to the bottom",
                translate: (x: 0.0, y: 50.0),
                expect: CGAffineTransform(a: 1.0, b: 0.0, c: -0.0, d: -1.0, tx: 0.0, ty: 50.0)
            ),
            #line: TestCase(
                description: "Move 40pt to the left, 20pt to the top",
                translate: (x: -40.0, y: -20.0),
                expect: CGAffineTransform(a: 1.0, b: 0.0, c: -0.0, d: -1.0, tx: -40.0, ty: 120.0)
            ),
        ]

        _ = testCases.map { (line, testCase) in
            let view = ProcessingView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))

            let translateDelegateSpy = ProcessingViewDelegateTranslateSpy(
                exception: expectation(description: "Point"),
                view: view,
                x: testCase.translate.x,
                y: testCase.translate.y
            )

            view.delegate = translateDelegateSpy
            waitForExpectations(timeout: 100)

            let actual = translateDelegateSpy.context?.ctm
            let expected = testCase.expect
            XCTAssertEqual(actual, expected, String(line))
        }
    }

    struct TestCase {
        let description: String
        let translate: (x: CGFloat, y: CGFloat)
        let expect: CGAffineTransform

        init(
            description: String,
            translate: (x: CGFloat, y: CGFloat),
            expect: CGAffineTransform
            ) {
            self.description = description
            self.translate = translate
            self.expect = expect
        }
    }
}
