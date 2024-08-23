//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public extension UIActivityIndicatorView {
    var setIsAnimating: Bool {
        get { isAnimating }
        set {
            if newValue {
                startAnimating()
            } else {
                stopAnimating()
            }
        }
    }
}
