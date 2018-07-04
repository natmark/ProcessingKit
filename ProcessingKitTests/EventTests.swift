//
//  EventTests.swift
//  ProcessingKitTests
//
//  Created by AtsuyaSato on 2018/07/04.
//  Copyright © 2018年 Atsuya Sato. All rights reserved.
//

import XCTest
@testable import ProcessingKit

class EventTests: XCTestCase {
    func testFingerPressed() {
        let view = ProcessingView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        XCTAssertEqual(view.fingerPressed, false)

        view.touchesBegan(createTouchEvent(), with: UIEvent())
        XCTAssertEqual(view.fingerPressed, true)

        view.touchesEnded(createTouchEvent(), with: UIEvent())
        XCTAssertEqual(view.fingerPressed, false)
    }

    private func createTouchEvent() -> Set<UITouch> {
        let tArr = NSMutableArray()
        tArr.add(UITouch())
        let touch = NSSet()
        touch.adding(tArr)

        return touch as? Set<UITouch> ?? Set()
    }
}
