//
//  ShapeTests.swift
//  ProcessingKitTests
//
//  Created by AtsuyaSato on 2018/01/29.
//  Copyright © 2018年 Atsuya Sato. All rights reserved.
//

import XCTest
@testable import ProcessingKit

class ShapeDelegateSpy: ProcessingViewDelegate {
    private let exception: XCTestExpectation
    private let view: ProcessingView
    private let x: CGFloat
    private let y: CGFloat
    private let width: CGFloat
    private let height: CGFloat
    private(set) var context: CGContext?

    init(exception: XCTestExpectation, view: ProcessingView, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        self.exception = exception
        self.view = view
        self.x = x
        self.y = y
        self.width = width
        self.height = height
    }

    func setup() {
        self.view.rect(x, y, width, height)
        self.record(UIGraphicsGetCurrentContext())
        exception.fulfill()
    }

    private func record(_ arg: CGContext?) {
        self.context = arg
    }
}

class ShapeTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testRect() {
        let view = ProcessingView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))

        let shapeDelegateSpy = ShapeDelegateSpy(
            exception: expectation(description: "Shape"),
            view: view,
            x: 0,
            y: 0,
            width: 10,
            height: 10
        )

        view.delegate = shapeDelegateSpy
        waitForExpectations(timeout: 100)

        let actual = shapeDelegateSpy.context?.path
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 10, y: 0))
        path.addLine(to: CGPoint(x: 10, y: 10))
        path.addLine(to: CGPoint(x: 0, y: 10))
        path.close()
        let expected = path.cgPath
        XCTAssertEqual(actual, expected, String(#line))
    }
}
