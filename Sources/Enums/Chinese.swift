//  Created by Thinh Nguyen
//

import Foundation
import SwiftUI

enum Chinese {
    static let title = brandFont(
        ofSize: 56,
        weight: .medium
    )

    static let heading1 = brandFont(
        ofSize: 40,
        weight: .regular
    )

    static let heading1UltraLight = brandFont(
        ofSize: 40,
        weight: .ultraLight
    )

    static let heading1Strong = brandFont(
        ofSize: 40,
        weight: .medium
    )

    static let heading2 = brandFont(
        ofSize: 32,
        weight: .regular
    )

    static let heading2UltraLight = brandFont(
        ofSize: 32,
        weight: .ultraLight
    )

    static let heading2Strong = brandFont(
        ofSize: 32,
        weight: .medium
    )

    static let heading3 = brandFont(
        ofSize: 24,
        weight: .regular
    )

    static let heading3UltraLight = brandFont(
        ofSize: 24,
        weight: .ultraLight
    )

    static let heading3Strong = brandFont(
        ofSize: 24,
        weight: .medium
    )

    static let heading4 = brandFont(
        ofSize: 18,
        weight: .regular
    )

    static let heading4Special = brandFont(
        ofSize: 20,
        weight: .regular
    )

    static let heading4Strong = brandFont(
        ofSize: 18,
        weight: .medium
    )

    static let heading5 = brandFont(
        ofSize: 16,
        weight: .medium
    )

    static let headingPdt = brandFont(
        ofSize: 14,
        weight: .regular
    )

    static let heading6 = brandFont(
        ofSize: 14,
        weight: .regular
    )

    static let heading7 = brandFont(
        ofSize: 12,
        weight: .medium
    )

    static let body1 = brandFont(
        ofSize: 16,
        weight: .regular
    )

    static let body1Strong = brandFont(
        ofSize: 16,
        weight: .medium
    )

    static let body2 = brandFont(
        ofSize: 14,
        weight: .regular
    )

    static let body2Strong = brandFont(
        ofSize: 14,
        weight: .medium
    )

    static let body3 = brandFont(
        ofSize: 12,
        weight: .regular
    )

    static let body3Strong = brandFont(
        ofSize: 12,
        weight: .medium
    )

    static let body4 = brandFont(
        ofSize: 10,
        weight: .regular
    )

    static let body4Strong = brandFont(
        ofSize: 10,
        weight: .medium
    )

    static let label1 = brandFont(
        ofSize: 16,
        weight: .regular
    )

    static let label2 = brandFont(
        ofSize: 12,
        weight: .regular
    )

    static let link1 = brandFont(
        ofSize: 14,
        weight: .regular
    )

    static let link2 = brandFont(
        ofSize: 12,
        weight: .regular
    )

    static let list1 = brandFont(
        ofSize: 16,
        weight: .regular
    )

    static let list2 = brandFont(
        ofSize: 14,
        weight: .regular
    )
}

extension Chinese {
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
}