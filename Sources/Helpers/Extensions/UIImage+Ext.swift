//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public extension UIImage {
    var aspectRate: CGFloat {
        size.width / size.height
    }
}

public extension UIImage {
    static var caretDown: UIImage { UIImage(resource: .caretDown) }
    static var close: UIImage { UIImage(resource: .close) }
    static var navigationRight: UIImage { UIImage(resource: .right) }
    static var statusError: UIImage { UIImage(resource: .statusError) }
    static var statusSuccess: UIImage { UIImage(resource: .statusSuccess) }
    static var inputFieldEdit: UIImage { UIImage(resource: .inputFieldEdit) }
    static var placeholder: UIImage { UIImage(resource: .placeholder) }
    static var closeCircle: UIImage { UIImage(resource: .closeCircle) }
}
