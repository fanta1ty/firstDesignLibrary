//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public extension UIButton {
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
