//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public extension UILabel {
    @IBInspectable var brandFont: String {
        get { return "" }
        set { font = UIFont.brandFont(named: newValue) }
    }

    @IBInspectable var localiseKey: String? {
        get { return nil }
        set { text = newValue?.localised }
    }
}
