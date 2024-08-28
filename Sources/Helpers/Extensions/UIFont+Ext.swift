//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public extension UIFont {
    static var body2: UIFont {
        ContextManager.shared.localiseManager.language.brandFont(named: "body2")
    }

    static var title: UIFont {
        ContextManager.shared.localiseManager.language.brandFont(named: "title")
    }

    static var heading1: UIFont {
        ContextManager.shared.localiseManager.language.brandFont(named: "heading1")
    }

    static var heading1UltraLight: UIFont {
        ContextManager.shared.localiseManager.language.brandFont(named: "heading1UltraLight")
    }

    static var heading1Strong: UIFont {
        ContextManager.shared.localiseManager.language.brandFont(named: "heading1Strong")
    }

    static var heading2: UIFont {
        ContextManager.shared.localiseManager.language.brandFont(named: "heading2")
    }

    static var heading2UltraLight: UIFont {
        ContextManager.shared.localiseManager.language.brandFont(named: "heading2UltraLight")
    }

    static var heading2Strong: UIFont {
        ContextManager.shared.localiseManager.language.brandFont(named: "heading2Strong")
    }

    static var heading3: UIFont {
        ContextManager.shared.localiseManager.language.brandFont(named: "heading3")
    }

    static var heading3UltraLight: UIFont {
        ContextManager.shared.localiseManager.language.brandFont(named: "heading3UltraLight")
    }

    static var heading3Strong: UIFont {
        ContextManager.shared.localiseManager.language.brandFont(named: "heading3Strong")
    }

    static var heading4: UIFont {
        ContextManager.shared.localiseManager.language.brandFont(named: "heading4")
    }

    static var heading4Special: UIFont {
        ContextManager.shared.localiseManager.language.brandFont(named: "heading4Special")
    }

    static var heading4Strong: UIFont {
        ContextManager.shared.localiseManager.language.brandFont(named: "heading4Strong")
    }

    static var heading5: UIFont {
        ContextManager.shared.localiseManager.language.brandFont(named: "heading5")
    }

    static var headingPdt: UIFont {
        ContextManager.shared.localiseManager.language.brandFont(named: "headingPdt")
    }

    static var heading6: UIFont {
        ContextManager.shared.localiseManager.language.brandFont(named: "heading6")
    }

    static var heading7: UIFont {
        ContextManager.shared.localiseManager.language.brandFont(named: "heading7")
    }

    static var body1: UIFont {
        ContextManager.shared.localiseManager.language.brandFont(named: "body1")
    }

    static var body1Strong: UIFont {
        ContextManager.shared.localiseManager.language.brandFont(named: "body1Strong")
    }

    static var body2Strong: UIFont {
        ContextManager.shared.localiseManager.language.brandFont(named: "body2Strong")
    }

    static var body3: UIFont {
        ContextManager.shared.localiseManager.language.brandFont(named: "body3")
    }

    static var body3Strong: UIFont {
        ContextManager.shared.localiseManager.language.brandFont(named: "body3Strong")
    }

    static var body4: UIFont {
        ContextManager.shared.localiseManager.language.brandFont(named: "body4")
    }

    static var body4Strong: UIFont {
        ContextManager.shared.localiseManager.language.brandFont(named: "body4Strong")
    }

    static var label1: UIFont {
        ContextManager.shared.localiseManager.language.brandFont(named: "label1")
    }

    static var label2: UIFont {
        ContextManager.shared.localiseManager.language.brandFont(named: "label2")
    }

    static var link1: UIFont {
        ContextManager.shared.localiseManager.language.brandFont(named: "link1")
    }

    static var link2: UIFont {
        ContextManager.shared.localiseManager.language.brandFont(named: "link2")
    }

    static var list1: UIFont {
        ContextManager.shared.localiseManager.language.brandFont(named: "list1")
    }

    static var list2: UIFont {
        ContextManager.shared.localiseManager.language.brandFont(named: "list2")
    }
}

public extension UIFont {
    static func brandFont(named: String) -> UIFont {
        switch named {
        case "title": return title
        case "heading1": return heading1
        case "heading1UltraLight": return heading1UltraLight
        case "heading1Strong": return heading1Strong
        case "heading2": return heading2
        case "heading2UltraLight": return heading2UltraLight
        case "heading2Strong": return heading2Strong
        case "heading3": return heading3
        case "heading3UltraLight": return heading3UltraLight
        case "heading3Strong": return heading3Strong
        case "heading4": return heading4
        case "heading4Special": return heading4Special
        case "heading4Strong": return heading4Strong
        case "heading5": return heading5
        case "headingPdt": return headingPdt
        case "heading6": return heading6
        case "heading7": return heading7
        case "body1": return body1
        case "body1Strong": return body1Strong
        case "body2": return body2
        case "body2Strong": return body2Strong
        case "body3": return body3
        case "body3Strong": return body3Strong
        case "body4": return body4
        case "body4Strong": return body4Strong
        case "label1": return label1
        case "label2": return label2
        case "link1": return link1
        case "link2": return link2
        case "list1": return list1
        case "list2": return list2
        default: return body1
        }
    }
}
