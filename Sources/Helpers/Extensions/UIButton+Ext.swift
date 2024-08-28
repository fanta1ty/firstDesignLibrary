//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public extension UIButton {
    @IBInspectable var brandFont: String {
        get { return "" }
        set { titleLabel?.brandFont = newValue }
    }

    @IBInspectable var localiseKey: String? {
        get { return nil }
        set { setTitle(newValue?.localised, for: .normal) }
    }

    @IBInspectable var isWrappedAndCentered: Bool {
        get { false }
        set {
            if newValue {
                titleLabel?.numberOfLines = 0
                titleLabel?.textAlignment = .center
            }
        }
    }
}
