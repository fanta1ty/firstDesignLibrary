//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public extension Optional where Wrapped == LocaliseManager.Language {
    func brandFont(named: String) -> UIFont {
        let language = Locale.current.language
        switch language {
        case .english, .none:
            switch named {
            case "title": return English.uiTitle
            case "heading1": return English.uiHeading1
            case "heading1UltraLight": return English.uiHeading1UltraLight
            case "heading1Strong": return English.uiHeading1Strong
            case "heading2": return English.uiHeading2
            case "heading2UltraLight": return English.uiHeading2UltraLight
            case "heading2Strong": return English.uiHeading2Strong
            case "heading3": return English.uiHeading3
            case "heading3UltraLight": return English.uiHeading3UltraLight
            case "heading3Strong": return English.uiHeading3Strong
            case "heading4": return English.uiHeading4
            case "heading4Special": return English.uiHeading4Special
            case "heading4Strong": return English.uiHeading4Strong
            case "heading5": return English.uiHeading5
            case "headingPdt": return English.uiHeadingPdt
            case "heading6": return English.uiHeading6
            case "heading7": return English.uiHeading7
            case "body1": return English.uiBody1
            case "body1Strong": return English.uiBody1Strong
            case "body2": return English.uiBody2
            case "body2Strong": return English.uiBody2Strong
            case "body3": return English.uiBody3
            case "body3Strong": return English.uiBody3Strong
            case "body4": return English.uiBody4
            case "body4Strong": return English.uiBody4Strong
            case "label1": return English.uiLabel1
            case "label2": return English.uiLabel2
            case "link1": return English.uiLink1
            case "link2": return English.uiLink2
            case "list1": return English.uiList1
            case "list2": return English.uiList2
            default: return English.uiBody1
            }
        case .chinese:
            switch named {
            case "title": return Chinese.uiTitle
            case "heading1": return Chinese.uiHeading1
            case "heading1UltraLight": return Chinese.uiHeading1UltraLight
            case "heading1Strong": return Chinese.uiHeading1Strong
            case "heading2": return Chinese.uiHeading2
            case "heading2UltraLight": return Chinese.uiHeading2UltraLight
            case "heading2Strong": return Chinese.uiHeading2Strong
            case "heading3": return Chinese.uiHeading3
            case "heading3UltraLight": return Chinese.uiHeading3UltraLight
            case "heading3Strong": return Chinese.uiHeading3Strong
            case "heading4": return Chinese.uiHeading4
            case "heading4Special": return Chinese.uiHeading4Special
            case "heading4Strong": return Chinese.uiHeading4Strong
            case "heading5": return Chinese.uiHeading5
            case "headingPdt": return Chinese.uiHeadingPdt
            case "heading6": return Chinese.uiHeading6
            case "heading7": return Chinese.uiHeading7
            case "body1": return Chinese.uiBody1
            case "body1Strong": return Chinese.uiBody1Strong
            case "body2": return Chinese.uiBody2
            case "body2Strong": return Chinese.uiBody2Strong
            case "body3": return Chinese.uiBody3
            case "body3Strong": return Chinese.uiBody3Strong
            case "body4": return Chinese.uiBody4
            case "body4Strong": return Chinese.uiBody4Strong
            case "label1": return Chinese.uiLabel1
            case "label2": return Chinese.uiLabel2
            case "link1": return Chinese.uiLink1
            case "link2": return Chinese.uiLink2
            case "list1": return Chinese.uiList1
            case "list2": return Chinese.uiList2
            default: return Chinese.uiBody1
            }
        }
    }
}
