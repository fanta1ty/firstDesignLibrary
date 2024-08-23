//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public extension NSMutableAttributedString {
    func with(strikethrough: String) -> NSMutableAttributedString {
        let range = mutableString.range(of: strikethrough)

        addAttribute(
            .strikethroughStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: range
        )

        return self
    }
}
