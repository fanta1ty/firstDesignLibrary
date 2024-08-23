//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public extension Date {
    static var minutesInMonth: Int {
        43800
    }
}

public extension Date {
    var asTimeAgoIfRecentOrShortTimeInTimezone: String {
        let sinceNow = Int(timeIntervalSinceNow)

        if sinceNow < 0 {
            let seconds = -sinceNow
            if seconds < 60 {
                return "less than a minute ago"
            }

            let minutes = seconds / 60
            if minutes < 60 {
                if minutes == 1 { return "\(minutes) minute ago" }
                else { return "\(minutes) minutes ago" }
            }

            let hours = minutes / 60
            if hours <= 6 {
                if hours == 1 { return "\(hours) hour ago" }
                else { return "\(hours) hours ago" }
            }
        }

        return asShortTime
    }

    var asMinutesFromNow: Double {
        let seconds = timeIntervalSinceNow
        let minutes = seconds / 60
        return minutes
    }

    var asYMDDateComponents: DateComponents? {
        Calendar.current.dateComponents([
            .era,
            .year,
            .month,
            .day,
        ],
        from: self)
    }

    var asYMDDateComponentsWithoutEra: DateComponents? {
        Calendar.current.dateComponents([
            .year,
            .month,
            .day,
        ],
        from: self)
    }

    var asdMMMyyyyAndShortTime: String {
        DateFormatter.dMMMyyyyAndShortTime.string(from: self)
    }

    var asYmdthmssssz: String {
        DateFormatter.ymdthmssssz.string(from: self)
    }

    var asShortTime: String {
        DateFormatter.shortTime.string(from: self)
    }

    var asYyyymmdd: String {
        DateFormatter.yyyyMMdd.string(from: self)
    }

    var asWeekday: Int? {
        Calendar.current.dateComponents([
            .weekday,
        ], from: self).weekday
    }

    var minutesSinceNow: String? {
        String(format: "%.1f", timeIntervalSinceNow / 60)
    }

    var asMediumTime: String? {
        DateFormatter.mediumTime.string(from: self)
    }

    var asDMMMyyyy: String {
        DateFormatter.dMMMyyyy.string(from: self)
    }

    var asDMMM: String {
        DateFormatter.dMMMM.string(from: self)
    }

    var asDMM: String {
        DateFormatter.dMMM.string(from: self)
    }

    var monthsDifferenccesRoundedUp: Int {
        let calendar = Calendar.current
        var fromDC = calendar.dateComponents([.year, .month, .day], from: Date())
        fromDC.day = 1

        var toDC = calendar.dateComponents([.year, .month, .day], from: self)
        toDC.day = 2

        guard let from = calendar.date(from: fromDC),
              let to = calendar.date(from: toDC),
              let month = calendar.dateComponents([.month], from: from, to: to).month else { return 1 }

        return max(month, 0) + 1
    }
}
