//  Created by Thinh Nguyen
//

import Foundation
import SwiftUI

public extension AttributedString {
    init(
        text: String,
        textFont: Font,
        textColor: SwiftUI.Color,
        highlight: String,
        highlightFont: Font,
        highlightColor: SwiftUI.Color
    ) {
        var attributedString = AttributedString(text)
        attributedString.font = textFont
        attributedString.foregroundColor = textColor

        if let range = attributedString.range(of: highlight) {
            attributedString[range].font = highlightFont
            attributedString[range].foregroundColor = highlightColor
        }

        self = attributedString
    }
}
