//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public extension Calendar {
    func middleOf(
        day: Int,
        month: Int,
        year: Int
    ) -> Date? {
        var dc = DateComponents()
        dc.day = day
        dc.month = month
        dc.year = year
        dc.hour = 12
        return date(from: dc)
    }

    func startOfCalendarFor(
        month: Int,
        year: Int
    ) -> Date? {
        guard let startOfMonth = middleOf(day: 1, month: month, year: year) else { return nil }

        var calendarStartDay = startOfMonth

        while true {
            guard let thisWeekday = weekday(date: calendarStartDay) else { return nil }

            if thisWeekday == firstWeekday { return calendarStartDay }

            guard let dayBefore = dayBefore(date: calendarStartDay) else { return nil }

            calendarStartDay = dayBefore
        }
    }

    func monthBeforeOrAfter(
        month: Int,
        year: Int,
        isForwards: Bool
    ) -> DateComponents? {
        guard let start = middleOf(day: 1, month: month, year: year) else { return nil }
        var delta = DateComponents()
        delta.month = isForwards ? 1 : -1

        guard let nextOrPrevMonth = date(byAdding: delta, to: start) else { return nil }
        return dateComponents([.month, .year], from: nextOrPrevMonth)
    }

    func calendarWeeks(
        forMonth month: Int,
        year: Int
    ) -> [[DateComponents]] {
        let daysInWeek = veryShortStandaloneWeekdaySymbols.count
        guard let calendarStartDate = startOfCalendarFor(month: month, year: year) else { return [] }
        var currentDate = calendarStartDate
        var currentDateDC = dateComponents([.month, .day, .year], from: currentDate)
        var weeks: [[DateComponents]] = []
        while true {
            var week: [DateComponents] = []
            for _ in 0 ..< daysInWeek {
                week.append(currentDateDC)

                guard let dayAfter = dayAfter(date: currentDate) else { return [] }
                currentDate = dayAfter
                currentDateDC = dateComponents([.month, .day, .year], from: currentDate)
            }
            weeks.append(week)

            let currentDateYM = (currentDateDC.year ?? 0) * 1000 + (currentDateDC.month ?? 0)
            let desiredYM = year * 1000 + month
            let isNextMonth = currentDateYM > desiredYM
            if isNextMonth { break }
        }
        return weeks
    }

    func weekday(date: Date) -> Int? {
        dateComponents([.weekday], from: date).weekday
    }

    func dayBefore(date d: Date) -> Date? {
        var dc = DateComponents()
        dc.day = -1

        return date(byAdding: dc, to: d)
    }

    func dayAfter(date d: Date) -> Date? {
        var dc = DateComponents()
        dc.day = 1
        return date(byAdding: dc, to: d)
    }
}
