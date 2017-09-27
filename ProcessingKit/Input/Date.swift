//
//  Date.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2017/09/27.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation

protocol DateModelContract {
    func millis() -> Int
    func second() -> Int
    func minute() -> Int
    func hour() -> Int
    func day() -> Int
    func month() -> Int
    func year() -> Int
}

struct DateModel: DateModelContract {
    var currentDate: Date?
    // for test
    init(currentDate: Date) {
        self.currentDate = currentDate
    }

    init() {
    }

    func millis() -> Int {
        return self.getMillis()
    }

    func second() -> Int {
        return self.getComponents().second ?? 0
    }

    func minute() -> Int {
        return self.getComponents().minute ?? 0
    }

    func hour() -> Int {
        return self.getComponents().hour ?? 0
    }

    func day() -> Int {
        return self.getComponents().day ?? 0
    }

    func month() -> Int {
        return self.getComponents().month ?? 0
    }

    func year() -> Int {
        return self.getComponents().year ?? 0
    }

    private func getMillis() -> Int {
        let format = DateFormatter()
        format.dateFormat = "SSS"
        let millsStr = format.string(from: currentDate ?? Date())
        return Int(millsStr) ?? 0
    }

    private func getComponents() -> DateComponents {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: currentDate ?? Date())
        return components
    }
}

extension ProcessingView: DateModelContract {
    func millis() -> Int {
        return self.dateModel.millis()
    }

    func second() -> Int {
        return self.dateModel.second()
    }

    func minute() -> Int {
        return self.dateModel.minute()
    }

    func hour() -> Int {
        return self.dateModel.hour()
    }

    func day() -> Int {
        return self.dateModel.day()
    }

    func month() -> Int {
        return self.dateModel.month()
    }

    func year() -> Int {
        return self.dateModel.year()
    }
}
