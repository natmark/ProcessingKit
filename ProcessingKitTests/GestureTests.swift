//
//  EventTests.swift
//  ProcessingKitTests
//
//  Created by AtsuyaSato on 2018/07/04.
//  Copyright © 2018年 Atsuya Sato. All rights reserved.
//

import XCTest
@testable import ProcessingKit

class GestureTests: XCTestCase {
    func testFingerPressed() {
        let view = ProcessingView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        XCTAssertEqual(view.fingerPressed, false)

        view.didTap(recognizer: view.tapGestureWithSingleTouch)
        XCTAssertEqual(view.fingerPressed, true)
    }
}
