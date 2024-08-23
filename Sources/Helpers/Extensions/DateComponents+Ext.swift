//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public extension DateComponents {
    var yyyymmdd: Int {
        let y = year ?? 0
        let m = month ?? 0
        let d = day ?? 0
        return y * 10000 + m * 100 + d
    }

    var dMMMyyyyPlusTodayIfAppropriate: String? {
        let today = Self.todayYMD
        let isToday = year == today.year && month == today.month && day == today.day
        let suffix = (isToday ? " Today" : "")
        guard let date = Calendar.current.date(from: self) else { return nil }

        return DateFormatter.dMMMyyyy.string(from: date) + suffix
    }

    var dMMMyyyyOrTodayIfAppropriate: String? {
        let today = Self.todayYMD
        let isToday = year == today.year && month == today.month && day == today.day
        if isToday { return "Today" }

        guard let date = Calendar.current.date(from: self) else { return nil }
        return DateFormatter.dMMMyyyy.string(from: date)
    }

    var dMMMyyyyEEEOrTodayIfAppropriate: String? {
        let today = Self.todayYMD
        let isToday = year == today.year && month == today.month && day == today.day
        if isToday { return "Today" }

        guard let date = Calendar.current.date(from: self) else { return nil }
        return DateFormatter.dMMMyyyyEEE.string(from: date)
    }

    var dMMMyyyy: String? {
        guard let date = Calendar.current.date(from: self) else { return nil }
        return DateFormatter.dMMMyyyy.string(from: date)
    }

    var ddMMMyyyy: String? {
        guard let date = Calendar.current.date(from: self) else { return nil }
        return DateFormatter.ddMMyyyy.string(from: date)
    }

    var yyyyMMddWithDash: String? {
        guard let date = Calendar.current.date(from: self) else { return nil }
        return DateFormatter.yyyyMMddWithDash.string(from: date)
    }

    var MMMMyyyy: String? {
        guard let date = Calendar.current.date(from: self) else { return nil }
        return DateFormatter.MMMMyyyy.string(from: date)
    }

    var MMMyyyy: String? {
        guard let date = Calendar.current.date(from: self) else { return nil }
        return DateFormatter.MMMyyyy.string(from: date)
    }

    var ymdthmssssz: String? {
        guard let date = Calendar.current.date(from: self) else { return nil }
        return DateFormatter.ymdthmssssz.string(from: date)
    }

    var MMMM: String? {
        guard let date = Calendar.current.date(from: self) else { return nil }
        return DateFormatter.MMMM.string(from: date)
    }

    var dMMM: String? {
        guard let date = Calendar.current.date(from: self) else { return nil }
        return DateFormatter.dMMM.string(from: date)
    }

    var MMM: String? {
        guard let date = Calendar.current.date(from: self) else { return nil }
        return DateFormatter.MMM.string(from: date)
    }

    var EEEE: String? {
        guard let date = Calendar.current.date(from: self) else { return nil }
        return DateFormatter.EEEE.string(from: date)
    }

    var asDate: Date? {
        Calendar.current.date(from: self)
    }

    var asEndOfDay: Date? {
        var endOfDay = self
        endOfDay.hour = 23
        endOfDay.minute = 59
        endOfDay.second = 59
        endOfDay.nanosecond = 999_999_999

        return Calendar.current.date(from: endOfDay)
    }

    var yearAheadDate: DateComponents {
        var yearAheadDate = self
        yearAheadDate.year = (year ?? 0) + 1
        yearAheadDate.day = (yearAheadDate.day ?? 0) - 1
        return yearAheadDate
    }

    var asStartOfMonth: Date? {
        var startOfMonth = self
        startOfMonth.day = 1
        startOfMonth.hour = 0
        startOfMonth.minute = 0
        startOfMonth.second = 0
        startOfMonth.nanosecond = 000_000_001
        return Calendar.current.date(from: startOfMonth)
    }

    var asEndOfMonth: Date? {
        var endOfMonth = self
        if let month = endOfMonth.month {
            endOfMonth.month = month + 1
        }

        endOfMonth.day = 0
        endOfMonth.hour = 23
        endOfMonth.minute = 59
        endOfMonth.second = 59
        endOfMonth.nanosecond = 999_999_999

        return Calendar.current.date(from: endOfMonth)
    }
}

public extension DateComponents {
    static var todayYMD: DateComponents {
        Calendar.current.dateComponents([
            .year,
            .month,
            .day,
        ],
        from: Date())
    }

    static var yesterdayYMD: DateComponents? {
        Calendar.current.date(byAdding: .day, value: -1, to: Date())?.asYMDDateComponentsWithoutEra
    }
}

public extension DateComponents {
    static func todayByAdding(days: Int) -> DateComponents {
        Calendar.current.date(
            byAdding: .day,
            value: days,
            to: Date()
        )?.asYMDDateComponents ?? .todayYMD
    }

    static func from(yyyymmdd: Int) -> DateComponents {
        .init(
            year: yyyymmdd / 10000,
            month: (yyyymmdd / 100) % 100,
            day: yyyymmdd % 100
        )
    }

    static func nextMonth(from date: Date) -> Date? {
        Calendar.current.date(byAdding: .month, value: 1, to: date)
    }
}
