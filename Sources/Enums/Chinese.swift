//  Created by Thinh Nguyen
//

import Foundation
import SwiftUI

public enum Chinese {
    static let title: Font = brandFont(
        ofSize: 56,
        weight: .medium
    )

    static let uiTitle: UIFont = brandFont(
        ofSize: 56,
        weight: .medium
    )

    static let heading1: Font = brandFont(
        ofSize: 40,
        weight: .regular
    )

    static let uiHeading1: UIFont = brandFont(
        ofSize: 40,
        weight: .regular
    )

    static let heading1UltraLight: Font = brandFont(
        ofSize: 40,
        weight: .ultraLight
    )

    static let uiHeading1UltraLight: UIFont = brandFont(
        ofSize: 40,
        weight: .ultraLight
    )

    static let heading1Strong: Font = brandFont(
        ofSize: 40,
        weight: .medium
    )

    static let uiHeading1Strong: UIFont = brandFont(
        ofSize: 40,
        weight: .medium
    )

    static let heading2: Font = brandFont(
        ofSize: 32,
        weight: .regular
    )

    static let uiHeading2: UIFont = brandFont(
        ofSize: 32,
        weight: .regular
    )

    static let heading2UltraLight: Font = brandFont(
        ofSize: 32,
        weight: .ultraLight
    )

    static let uiHeading2UltraLight: UIFont = brandFont(
        ofSize: 32,
        weight: .ultraLight
    )

    static let heading2Strong: Font = brandFont(
        ofSize: 32,
        weight: .medium
    )

    static let uiHeading2Strong: UIFont = brandFont(
        ofSize: 32,
        weight: .medium
    )

    static let heading3: Font = brandFont(
        ofSize: 24,
        weight: .regular
    )

    static let uiHeading3: UIFont = brandFont(
        ofSize: 24,
        weight: .regular
    )

    static let heading3UltraLight: Font = brandFont(
        ofSize: 24,
        weight: .ultraLight
    )

    static let uiHeading3UltraLight: UIFont = brandFont(
        ofSize: 24,
        weight: .ultraLight
    )

    static let heading3Strong: Font = brandFont(
        ofSize: 24,
        weight: .medium
    )

    static let uiHeading3Strong: UIFont = brandFont(
        ofSize: 24,
        weight: .medium
    )

    static let heading4: Font = brandFont(
        ofSize: 18,
        weight: .regular
    )

    static let uiHeading4: UIFont = brandFont(
        ofSize: 18,
        weight: .regular
    )

    static let heading4Special: Font = brandFont(
        ofSize: 20,
        weight: .regular
    )

    static let uiHeading4Special: UIFont = brandFont(
        ofSize: 20,
        weight: .regular
    )

    static let heading4Strong: Font = brandFont(
        ofSize: 18,
        weight: .medium
    )

    static let uiHeading4Strong: UIFont = brandFont(
        ofSize: 18,
        weight: .medium
    )

    static let heading5: Font = brandFont(
        ofSize: 16,
        weight: .medium
    )

    static let uiHeading5: UIFont = brandFont(
        ofSize: 16,
        weight: .medium
    )

    static let headingPdt: Font = brandFont(
        ofSize: 14,
        weight: .regular
    )

    static let uiHeadingPdt: UIFont = brandFont(
        ofSize: 14,
        weight: .regular
    )

    static let heading6: Font = brandFont(
        ofSize: 14,
        weight: .regular
    )

    static let uiHeading6: UIFont = brandFont(
        ofSize: 14,
        weight: .regular
    )

    static let heading7: Font = brandFont(
        ofSize: 12,
        weight: .medium
    )

    static let uiHeading7: UIFont = brandFont(
        ofSize: 12,
        weight: .medium
    )

    static let body1: Font = brandFont(
        ofSize: 16,
        weight: .regular
    )

    static let uiBody1: UIFont = brandFont(
        ofSize: 16,
        weight: .regular
    )

    static let body1Strong: Font = brandFont(
        ofSize: 16,
        weight: .medium
    )

    static let uiBody1Strong: UIFont = brandFont(
        ofSize: 16,
        weight: .medium
    )

    static let body2: Font = brandFont(
        ofSize: 14,
        weight: .regular
    )

    static let uiBody2: UIFont = brandFont(
        ofSize: 14,
        weight: .regular
    )

    static let body2Strong: Font = brandFont(
        ofSize: 14,
        weight: .medium
    )

    static let uiBody2Strong: UIFont = brandFont(
        ofSize: 14,
        weight: .medium
    )

    static let body3: Font = brandFont(
        ofSize: 12,
        weight: .regular
    )

    static let uiBody3: UIFont = brandFont(
        ofSize: 12,
        weight: .regular
    )

    static let body3Strong: Font = brandFont(
        ofSize: 12,
        weight: .medium
    )

    static let uiBody3Strong: UIFont = brandFont(
        ofSize: 12,
        weight: .medium
    )

    static let body4: Font = brandFont(
        ofSize: 10,
        weight: .regular
    )

    static let uiBody4: UIFont = brandFont(
        ofSize: 10,
        weight: .regular
    )

    static let body4Strong: Font = brandFont(
        ofSize: 10,
        weight: .medium
    )

    static let uiBody4Strong: UIFont = brandFont(
        ofSize: 10,
        weight: .medium
    )

    static let label1: Font = brandFont(
        ofSize: 16,
        weight: .regular
    )

    static let uiLabel1: UIFont = brandFont(
        ofSize: 16,
        weight: .regular
    )

    static let label2: Font = brandFont(
        ofSize: 12,
        weight: .regular
    )

    static let uiLabel2: UIFont = brandFont(
        ofSize: 12,
        weight: .regular
    )

    static let link1: Font = brandFont(
        ofSize: 14,
        weight: .regular
    )

    static let uiLink1: UIFont = brandFont(
        ofSize: 14,
        weight: .regular
    )

    static let link2: Font = brandFont(
        ofSize: 12,
        weight: .regular
    )

    static let uiLink2: UIFont = brandFont(
        ofSize: 12,
        weight: .regular
    )

    static let list1: Font = brandFont(
        ofSize: 16,
        weight: .regular
    )

    static let uiList1: UIFont = brandFont(
        ofSize: 16,
        weight: .regular
    )

    static let list2: Font = brandFont(
        ofSize: 14,
        weight: .regular
    )

    static let uiList2: UIFont = brandFont(
        ofSize: 14,
        weight: .regular
    )
}

public extension Chinese {
    static func brandFont(
        ofSize size: CGFloat,
        weight: Font.Weight
    ) -> Font {
        let name: String

        switch weight {
        case .ultraLight:
            name = "NotoSansSC-Thin"

        case .regular:
            name = "NotoSansSC-Regular"

        case .medium:
            name = "NotoSansSC-Medium"

        default: return .system(.title)
        }

        return .custom(name, fixedSize: size)
            .weight(weight)
    }

    static func brandFont(
        ofSize size: CGFloat,
        weight: UIFont.Weight
    ) -> UIFont {
        let name: String

        switch weight {
        case .ultraLight:
            name = "NotoSansSC-Thin"

        case .regular:
            name = "NotoSansSC-Regular"

        case .medium:
            name = "NotoSansSC-Medium"

        default: return .systemFont(ofSize: size, weight: weight)
        }

        return .init(name: name, size: size) ?? .systemFont(ofSize: size, weight: weight)
    }
}
