//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public extension NSAttributedString {
    static func combining(_ strings: NSAttributedString...) -> NSAttributedString {
        let mutable = NSMutableAttributedString()
        for string in strings {
            mutable.append(string)
        }
        return NSAttributedString(attributedString: mutable)
    }

    static func with(
        text: String,
        textColor: UIColor,
        font: UIFont
    ) -> NSAttributedString {
        NSAttributedString(string: text, attributes: [
            .font: font,
            .foregroundColor: textColor,
        ])
    }
}

public extension NSAttributedString {
    convenience init(
        text: String,
        textFont: UIFont,
        textColor: UIColor,
        highlight: String? = nil,
        highlightFont: UIFont? = nil,
        highlightColor: UIColor? = nil
    ) {
        let attributedText = NSMutableAttributedString(string: text, attributes: [
            .font: textFont,
            .foregroundColor: textColor,
        ])

        if let highlight {
            let range = attributedText.mutableString.range(of: highlight)

            if let highlightFont {
                attributedText.addAttribute(.font, value: highlightFont, range: range)
            }

            if let highlightColor {
                attributedText.addAttribute(.foregroundColor, value: highlightColor, range: range)
            }
        }

        self.init(attributedString: attributedText)
    }
}
