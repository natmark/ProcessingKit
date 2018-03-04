//
//  ShapeTests.swift
//  ProcessingKitTests
//
//  Created by AtsuyaSato on 2018/01/29.
//  Copyright © 2018年 Atsuya Sato. All rights reserved.
//

import XCTest
@testable import ProcessingKit

enum Shape {
    case point(x: CGFloat, y: CGFloat)
    case line(x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat)
    case rect(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat)
    case ellipse(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat)
    case arc(x: CGFloat, y: CGFloat, radius: CGFloat, start: CGFloat, stop: CGFloat)
    case triangle(x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat, x3: CGFloat, y3: CGFloat)
    case quad(x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat, x3: CGFloat, y3: CGFloat, x4: CGFloat, y4: CGFloat)
    case curve(cpx1: CGFloat, cpy1: CGFloat, x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat, cpx2: CGFloat, cpy2: CGFloat)
    case bezier(x1: CGFloat, y1: CGFloat, cpx1: CGFloat, cpy1: CGFloat, cpx2: CGFloat, cpy2: CGFloat, x2: CGFloat, y2: CGFloat)
}

class ProcessingViewDelegateShapeSpy: ProcessingViewDelegate {
    private let exception: XCTestExpectation
    private let view: ProcessingView
    private let shape: Shape
    private(set) var context: CGContext?

    init(exception: XCTestExpectation, view: ProcessingView, shape: Shape) {
        self.exception = exception
        self.view = view
        self.shape = shape
    }

    func setup() {
        switch shape {
        case .point(let x, let y):
            self.view.point(x, y)
        case .line(let x1, let y1, let x2, let y2):
            self.view.line(x1, y1, x2, y2)
        case .rect(let x, let y, let width, let height):
            self.view.rect(x, y, width, height)
        case .ellipse(let x, let y, let width, let height):
            self.view.ellipse(x, y, width, height)
        case .arc(let x, let y, let radius, let start, let stop):
            self.view.arc(x, y, radius, start, stop)
        case .triangle(let x1, let y1, let x2, let y2, let x3, let y3):
            self.view.triangle(x1, y1, x2, y2, x3, y3)
        case .quad(let x1, let y1, let x2, let y2, let x3, let y3, let x4, let y4):
            self.view.quad(x1, y1, x2, y2, x3, y3, x4, y4)
        case .curve(let cpx1, let cpy1, let x1, let y1, let x2, let y2, let cpx2, let cpy2):
            self.view.curve(cpx1, cpy1, x1, y1, x2, y2, cpx2, cpy2)
        case .bezier(let x1, let y1, let cpx1, let cpy1, let cpx2, let cpy2, let x2, let y2):
            self.view.bezier(x1, y1, cpx1, cpy1, cpx2, cpy2, x2, y2)
        }
        self.record(UIGraphicsGetCurrentContext())
        exception.fulfill()
    }

    private func record(_ arg: CGContext?) {
        self.context = arg
    }
}

extension UIBezierPath {
    open func moveTo(_ point: CGPoint) -> UIBezierPath {
        self.move(to: point)
        return self
    }

    open func addLineTo(_ point: CGPoint) -> UIBezierPath {
        self.addLine(to: point)
        return self
    }

    open func addCurveTo(_ points: (to: CGPoint, controlPoint1: CGPoint, controlPoint2: CGPoint)) -> UIBezierPath {
        self.addCurve(to: points.to, controlPoint1: points.controlPoint1, controlPoint2: points.controlPoint2)
        return self
    }

    open func closePath() -> UIBezierPath {
        self.close()
        return self
    }
}

class ShapeTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testPoint() {
        let testCases: [UInt: TestCase] = [
            #line: TestCase(
                description: "draw point(50, 50)",
                shape: .point(x: 50, y: 50),
                expect: .right([
                    CGPoint(x: 50, y: 50.5),
                    CGPoint(x: 49.5, y: 50),
                    CGPoint(x: 50, y: 49.5),
                    CGPoint(x: 50.5, y: 50),
                ])
            ),
            ]

        check(testCases: testCases)
    }

    func testLine() {
        let testCases: [UInt: TestCase] = [
            #line: TestCase(
                description: "draw line(0, 0, 100, 100)",
                shape: .line(x1: 0, y1: 0, x2: 100, y2: 100),
                expect: .left(
                    UIBezierPath()
                        .moveTo(CGPoint(x: 0, y: 0))
                        .addLineTo(CGPoint(x: 100, y: 100))
                        .cgPath
                )
            ),
            #line: TestCase(
                description: "draw line(50, 50, -50, -50)",
                shape: .line(x1: 50, y1: 50, x2: -50, y2: -50),
                expect: .left(
                    UIBezierPath()
                        .moveTo(CGPoint(x: 50, y: 50))
                        .addLineTo(CGPoint(x: -50, y: -50))
                        .cgPath
                )
            ),
            ]

        check(testCases: testCases)
    }

    func testRect() {
        let testCases: [UInt: TestCase] = [
            #line: TestCase(
                description: "draw rect(0, 0, 50, 50)",
                shape: .rect(x: 0, y: 0, width: 50, height: 50),
                expect: .left(
                    UIBezierPath()
                    .moveTo(CGPoint(x: 0, y: 0))
                    .addLineTo(CGPoint(x: 50, y: 0))
                    .addLineTo(CGPoint(x: 50, y: 50))
                    .addLineTo(CGPoint(x: 0, y: 50))
                    .closePath()
                    .cgPath
                )
            ),
            #line: TestCase(
                description: "draw rect(20, 20, 30, 50)",
                shape: .rect(x: 20, y: 20, width: 30, height: 50),
                expect: .left(
                    UIBezierPath()
                    .moveTo(CGPoint(x: 20, y: 20))
                    .addLineTo(CGPoint(x: 50, y: 20))
                    .addLineTo(CGPoint(x: 50, y: 70))
                    .addLineTo(CGPoint(x: 20, y: 70))
                    .closePath()
                    .cgPath
                )
            ),
        ]

        check(testCases: testCases)
    }

    func testElipse() {
        let testCases: [UInt: TestCase] = [
            #line: TestCase(
                description: "draw ellipse(100, 100, 100, 100)",
                shape: .ellipse(x: 100, y: 100, width: 100, height: 100),
                expect: .right([
                    CGPoint(x: 150, y: 100),
                    CGPoint(x: 100, y: 150),
                    CGPoint(x: 50, y: 100),
                    CGPoint(x: 100, y: 50),
                    ]
                )
            ),
            #line: TestCase(
                description: "draw ellipse(0, 0, 100, 100)",
                shape: .ellipse(x: 0, y: 0, width: 100, height: 100),
                expect: .right([
                    CGPoint(x: 50, y: 0),
                    CGPoint(x: 0, y: 50),
                    CGPoint(x: -50, y: 0),
                    CGPoint(x: 0, y: -50),
                    ]
                )
            ),
            ]

        check(testCases: testCases)
    }

    func testArc() {
        func radians(_ degrees: CGFloat) -> CGFloat {
            let radian = (CGFloat.pi * 2) * (degrees / 360.0)
            return radian
        }

        let testCases: [UInt: TestCase] = [
            #line: TestCase(
                description: "draw arc(50, 50, 50, 0°, 90°)",
                shape: .arc(x: 50, y: 50, radius: 50, start: radians(0), stop: radians(90.0)),
                expect: .right([
                    CGPoint(x: 100, y: 50),
                    CGPoint(x: 50, y: 100),
                    ]
                )
            ),
            #line: TestCase(
                description: "draw arc(50, 50, 50, 0°, 270°)",
                shape: .arc(x: 50, y: 50, radius: 50, start: radians(0), stop: radians(270.0)),
                expect: .right([
                    CGPoint(x: 100, y: 50),
                    CGPoint(x: 50, y: 100),
                    CGPoint(x: 0, y: 50),
                    ]
                )
            ),
            ]

        check(testCases: testCases)
    }

    func testTriangle() {
        let testCases: [UInt: TestCase] = [
            #line: TestCase(
                description: "draw triangle(50, 0, 0, 100, 100, 100)",
                shape: .triangle(x1: 50, y1: 0, x2: 0, y2: 100, x3: 100, y3: 100),
                expect: .left(
                    UIBezierPath()
                        .moveTo(CGPoint(x: 50, y: 0))
                        .addLineTo(CGPoint(x: 0, y: 100))
                        .addLineTo(CGPoint(x: 100, y: 100))
                        .closePath()
                        .cgPath
                )
            ),
            ]

        check(testCases: testCases)
    }

    func testQuad() {
        let testCases: [UInt: TestCase] = [
            #line: TestCase(
                description: "draw triangle(0, 0, 30, 0, 100, 100, 40, 50)",
                shape: .quad(x1: 0, y1: 0, x2: 30, y2: 0, x3: 100, y3: 100, x4: 40, y4: 50),
                expect: .left(
                    UIBezierPath()
                        .moveTo(CGPoint(x: 0, y: 0))
                        .addLineTo(CGPoint(x: 30, y: 0))
                        .addLineTo(CGPoint(x: 100, y: 100))
                        .addLineTo(CGPoint(x: 40, y: 50))
                        .closePath()
                        .cgPath
                )
            ),
            ]

        check(testCases: testCases)
    }

    func testCurve() {
        let testCases: [UInt: TestCase] = [
            #line: TestCase(
                description: "draw curve(40, 40, 80, 60, 100, 100, 60, 120)",
                shape: .curve(cpx1: 40, cpy1: 40, x1: 80, y1: 60, x2: 100, y2: 100, cpx2: 60, cpy2: 120),
                expect: .right([
                    CGPoint(x: 80, y: 60),
                    CGPoint(x: 100, y: 100),
                    ]
                )
            ),
            ]

        check(testCases: testCases)
    }

    func testBezier() {
        let testCases: [UInt: TestCase] = [
            #line: TestCase(
                description: "draw bezier(40, 40, 80, 60, 100, 100, 60, 120)",
                shape: .bezier(x1: 40, y1: 40, cpx1: 80, cpy1: 60, cpx2: 100, cpy2: 100, x2: 60, y2: 120),
                expect: .right([
                    CGPoint(x: 40, y: 40),
                    CGPoint(x: 60, y: 120),
                    ]
                )
            ),
            ]

        check(testCases: testCases)
    }

    func check(testCases: [UInt: TestCase]) {
        _ = testCases.map { (line, testCase) in
            let view = ProcessingView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))

            let transformDelegateSpy = ProcessingViewDelegateShapeSpy(
                exception: expectation(description: testCase.description),
                view: view,
                shape: testCase.shape
            )

            view.delegate = transformDelegateSpy
            waitForExpectations(timeout: 100)

            let actual = transformDelegateSpy.context?.path
            let expected = testCase.expect

            switch expected {
            case .left(let path):
                XCTAssertEqual(actual, path, String(line))
            case .right(let points):
                for point in points {
                    XCTAssertTrue(actual?.contains(point) ?? false, String(line))
                }
            }
        }
    }

    enum Either<T, U> {
        case left(T)
        case right(U)
    }

    struct TestCase {
        let description: String
        let shape: Shape
        let expect: Either<CGPath, [CGPoint]>
    }
}
