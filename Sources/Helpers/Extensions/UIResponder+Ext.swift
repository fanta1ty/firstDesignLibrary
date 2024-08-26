//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public extension UIResponder {
    var navigationControllerViaResponders: UINavigationController? {
        if let nav = self as? UINavigationController { return nav }
        else { return next?.navigationControllerViaResponders }
    }
}
