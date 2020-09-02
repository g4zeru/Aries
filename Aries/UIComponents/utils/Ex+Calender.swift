//
//  Ex+Calender.swift
//  Aries
//
//  Created by Haruta Yamada on 2020/08/20.
//

import Foundation

extension TimeZone {
    
    static let japan = TimeZone(identifier: "Asia/Tokyo")!
}

extension Locale {
    
    static let japan = Locale(identifier: "ja_JP")
}

extension Calendar {
    static var shared: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = .japan
        calendar.locale   = .japan
        return calendar
    }()
    func startOfWeek(for date:Date) -> Date {
        let comps = self.dateComponents([.weekOfYear, .yearForWeekOfYear], from: date)
        return self.date(from: comps)!
    }
    func startOfMonth(for date:Date) -> Date {
        let comps = dateComponents([.month, .year], from: date)
        return self.date(from: comps)!
    }
    func move(_ date:Date, byWeeks weeks:Int) -> Date {
        return self.date(byAdding: .weekOfYear, value: weeks, to: startOfWeek(for: date))!
    }

    func move(_ date:Date, byMonths months:Int) -> Date {
        return self.date(byAdding: .month, value: months, to: startOfMonth(for: date))!
    }
}
