//
//  DateTests.swift
//  ProcessingKitTests
//
//  Created by AtsuyaSato on 2017/09/27.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import XCTest
@testable import ProcessingKit

class DateTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDateValue() {
        var components = DateComponents()
        components.year = 2017
        components.month = 5
        components.day = 20
        components.hour = 22
        components.minute = 50
        components.second = 10

        let calendar = Calendar(identifier: .gregorian)
        let date = calendar.date(from: components)

        guard let currentDate = date else {
            XCTFail()
            return
        }

        let dateModel = DateModel(startDate: Date(), currentDate: currentDate)

        XCTAssertEqual(dateModel.year(), 2017)
        XCTAssertEqual(dateModel.month(), 5)
        XCTAssertEqual(dateModel.day(), 20)
        XCTAssertEqual(dateModel.hour(), 22)
        XCTAssertEqual(dateModel.minute(), 50)
        XCTAssertEqual(dateModel.second(), 10)
    }
}
