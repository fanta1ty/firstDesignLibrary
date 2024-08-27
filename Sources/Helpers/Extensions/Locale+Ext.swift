//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public extension Locale {
    var language: LocaliseManager.Language? {
        if let language = LocaliseManager.Language(rawValue: identifier) {
            return language
        } else if identifier.starts(with: "en") {
            return .english
        } else if identifier.starts(with: "zh") {
            return .chinese
        } else { return nil }
    }
}

public extension Locale {
    static func enUsPosix() -> Locale {
        Locale(identifier: "en_US_POSIX")
    }
}
