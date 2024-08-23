//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public extension DateFormatter {
    static let dMMMyyyy: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = DateFormatter.dateFormat(
            fromTemplate: "dMMMyyyy",
            options: 0,
            locale: .current
        )
        return df
    }()

    static let dMMMyyyyEEE: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = DateFormatter.dateFormat(
            fromTemplate: "dMMMyyyyEEE",
            options: 0,
            locale: .current
        )
        return df
    }()

    static let MMMMyyyy: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = DateFormatter.dateFormat(
            fromTemplate: "MMMMyyyy",
            options: 0,
            locale: .current
        )
        return df
    }()

    static let yyyyMMdd: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = DateFormatter.dateFormat(
            fromTemplate: "yyyyMMdd",
            options: 0,
            locale: .current
        )
        return df
    }()

    static let MMMyyyy: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = DateFormatter.dateFormat(
            fromTemplate: "MMMyyyy",
            options: 0,
            locale: .current
        )
        return df
    }()

    static let dMMMMyyyy: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = DateFormatter.dateFormat(
            fromTemplate: "dMMMMyyyy",
            options: 0,
            locale: .current
        )
        return df
    }()

    static let dMMM: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = DateFormatter.dateFormat(
            fromTemplate: "dMMM",
            options: 0,
            locale: .current
        )
        return df
    }()

    static let dMMMM: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = DateFormatter.dateFormat(
            fromTemplate: "dMMMM",
            options: 0,
            locale: .current
        )
        return df
    }()

    static let ddMMyyyy: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = DateFormatter.dateFormat(
            fromTemplate: "ddMMyyyy",
            options: 0,
            locale: .current
        )
        return df
    }()

    static let shortTime: DateFormatter = {
        let df = DateFormatter()
        df.timeStyle = .short
        return df
    }()

    static let dMMMyyyyAndShortTime: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = DateFormatter.dateFormat(
            fromTemplate: "dMMMyyyy" + shortTime.dateFormat,
            options: 0,
            locale: .current
        )
        return df
    }()

    static let dMMMAndShortTime: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = DateFormatter.dateFormat(
            fromTemplate: "dMMM" + shortTime.dateFormat,
            options: 0,
            locale: .current
        )
        return df
    }()

    static let ymdthmssssz: DateFormatter = {
        let df = DateFormatter()
        df.calendar = .init(identifier: .iso8601)
        df.locale = .enUsPosix()
        df.timeZone = .init(secondsFromGMT: 0)
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSX"
        return df
    }()

    static let ymdhmss: DateFormatter = {
        let df = DateFormatter()
        df.calendar = .init(identifier: .iso8601)
        df.locale = .enUsPosix()
        df.timeZone = .init(secondsFromGMT: 0)
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return df
    }()

    static let MMMM: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = DateFormatter.dateFormat(
            fromTemplate: "MMMM",
            options: 0,
            locale: .current
        )
        return df
    }()

    static let MMM: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = DateFormatter.dateFormat(
            fromTemplate: "MMM",
            options: 0,
            locale: .current
        )
        return df
    }()

    static let yyyyMMddWithDash: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        return df
    }()

    static let mediumTime: DateFormatter = {
        let df = DateFormatter()
        df.timeStyle = .medium
        return df
    }()

    static let EEEE: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = DateFormatter.dateFormat(
            fromTemplate: "EEEE",
            options: 0,
            locale: .current
        )
        return df
    }()
}
