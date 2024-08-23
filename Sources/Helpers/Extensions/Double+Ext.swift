//  Created by Thinh Nguyen
//

import Foundation

public extension Double {
    var kmFormatted: String {
        if self >= 1_000_000 {
            var str = String(format: "%.3f", locale: .current, self / 1_000_000)
                .replacingOccurrences(of: ".0", with: "")
            str.removeLast(2)
            return str + "M"
        } else if self >= 10000 {
            var str = String(format: "%.3f", locale: .current, self / 1000)
                .replacingOccurrences(of: ".0", with: "")
            str.removeLast(2)
            return str + "K"
        } else {
            return String(format: "%.0f", locale: .current, self)
        }
    }
}

public extension Double {
    func round(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
