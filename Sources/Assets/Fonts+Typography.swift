//  Created by Thinh Nguyen
//

import Foundation
import SwiftUI

public struct TTypography {
    public let title: Font
    public let heading1: Font
    public let heading2: Font
    public let heading1UltraLight: Font
    public let heading2UltraLight: Font
    public let heading2Strong: Font
    public let heading3: Font
    public let heading3UltraLight: Font
    public let heading3Strong: Font
    public let heading4: Font
    public let heading4Special: Font
    public let heading4Strong: Font
    public let heading5: Font
    public let headingPdt: Font
    public let heading6: Font
    public let heading7: Font
    public let body1: Font
    public let body1Strong: Font
    public let body2: Font
    public let body2Strong: Font
    public let body3: Font
    public let body3Strong: Font
    public let body4: Font
    public let body4Strong: Font
    public let label1: Font
    public let label2: Font
    public let link1: Font
    public let link2: Font
    public let list1: Font
    public let list2: Font
}

public extension TTypography {
    static let english = TTypography(
        title: English.title,
        heading1: English.heading1,
        heading2: English.heading2,
        heading1UltraLight: English.heading1UltraLight,
        heading2UltraLight: English.heading2UltraLight,
        heading2Strong: English.heading2Strong,
        heading3: English.heading3,
        heading3UltraLight: English.heading3UltraLight,
        heading3Strong: English.heading3Strong,
        heading4: English.heading4,
        heading4Special: English.heading4Special,
        heading4Strong: English.heading4Strong,
        heading5: English.heading5,
        headingPdt: English.headingPdt,
        heading6: English.heading6,
        heading7: English.heading7,
        body1: English.body1,
        body1Strong: English.body1Strong,
        body2: English.body2,
        body2Strong: English.body2Strong,
        body3: English.body3,
        body3Strong: English.body3Strong,
        body4: English.body4,
        body4Strong: English.body4Strong,
        label1: English.label1,
        label2: English.label2,
        link1: English.link1,
        link2: English.link2,
        list1: English.list1,
        list2: English.list2
    )

    static let chinese = TTypography(
        title: Chinese.title,
        heading1: Chinese.heading1,
        heading2: Chinese.heading2,
        heading1UltraLight: Chinese.heading1UltraLight,
        heading2UltraLight: Chinese.heading2UltraLight,
        heading2Strong: Chinese.heading2Strong,
        heading3: Chinese.heading3,
        heading3UltraLight: Chinese.heading3UltraLight,
        heading3Strong: Chinese.heading3Strong,
        heading4: Chinese.heading4,
        heading4Special: Chinese.heading4Special,
        heading4Strong: Chinese.heading4Strong,
        heading5: Chinese.heading5,
        headingPdt: Chinese.headingPdt,
        heading6: Chinese.heading6,
        heading7: Chinese.heading7,
        body1: Chinese.body1,
        body1Strong: Chinese.body1Strong,
        body2: Chinese.body2,
        body2Strong: Chinese.body2Strong,
        body3: Chinese.body3,
        body3Strong: Chinese.body3Strong,
        body4: Chinese.body4,
        body4Strong: Chinese.body4Strong,
        label1: Chinese.label1,
        label2: Chinese.label2,
        link1: Chinese.link1,
        link2: Chinese.link2,
        list1: Chinese.list1,
        list2: Chinese.list2
    )
}
