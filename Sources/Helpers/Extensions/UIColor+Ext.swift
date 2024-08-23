//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public extension UIColor {
    convenience init?(hexString hex: String) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines)
            .uppercased()

        if cString.hasPrefix("#") { cString.remove(at: cString.startIndex) }

        guard cString.count == 6 else { return nil }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    convenience init(
        lightHex: String,
        darkHex: String
    ) {
        let light = lightHex.asColor ?? .gray
        let dark = darkHex.asColor ?? .gray

        self.init { traits in
            traits.userInterfaceStyle == .dark ? dark : light
        }
    }

    convenience init(
        startColor: UIColor,
        endColor: UIColor,
        percent: CGFloat
    ) {
        let (r1, g1, b1, a1) = startColor.rgba
        let (r2, g2, b2, a2) = endColor.rgba

        let r = r1 + percent * (r2 - r1)
        let g = g1 + percent * (g2 - g1)
        let b = b1 + percent * (b2 - b1)
        let a = a1 + percent * (a2 - a1)
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}

public extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red, green, blue, alpha)
    }
}
