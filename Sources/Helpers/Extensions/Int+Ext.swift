//  Created by Thinh Nguyen
//

import Foundation

public extension Int {
    var asInt32: Int32 {
        Int32(self)
    }

    var shortOrdinal: String {
        let lastDigit = self % 10
        if lastDigit == 1 && self != 11 {
            return String(format: "%dst", self)
        } else if lastDigit == 2 && self != 12 {
            return String(format: "%dnd", self)
        } else if lastDigit == 3 && self != 13 {
            return String(format: "%drd", self)
        } else {
            return String(format: "%dth", self)
        }
    }
}
