//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public extension UIImageView {
    enum AssociatedKeys {
        static var setImageKey = "setImageKey"
    }

    var setImageKey: String? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.setImageKey) as? String }
        set {
            if let newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.setImageKey, newValue as NSString?, .OBJC_ASSOCIATION_RETAIN)
            }
        }
    }
}
