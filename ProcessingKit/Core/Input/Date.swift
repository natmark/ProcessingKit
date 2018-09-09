//
//  Date.swift
//  ProcessingKit
//
//  Created by AtsuyaSato on 2017/09/27.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation

public protocol DateModelContract {
    func millis() -> Int
    func second() -> Int
    func minute() -> Int
    func hour() -> Int
    func day() -> Int
    func month() -> Int
    func year() -> Int
}

public struct DateModel: DateModelContract {
    private var currentDate: Date?
    // for test
    public init(currentDate: Date) {
        self.currentDate = currentDate
    }

    init() {
    }

    public func millis() -> Int {
        return self.getMillis()
    }

    public func second() -> Int {
        return self.getComponents().second ?? 0
    }

    public func minute() -> Int {
        return self.getComponents().minute ?? 0
    }

    public func hour() -> Int {
        return self.getComponents().hour ?? 0
    }

    public func day() -> Int {
        return self.getComponents().day ?? 0
    }

    public func month() -> Int {
        return self.getComponents().month ?? 0
    }

    public func year() -> Int {
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
