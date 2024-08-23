//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public extension CACornerMask {
    static var all: CACornerMask {
        [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner,
            .layerMinXMaxYCorner,
            .layerMaxXMaxYCorner,
        ]
    }

    static var top: CACornerMask {
        [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner,
        ]
    }

    static var bottom: CACornerMask {
        [
            .layerMinXMaxYCorner,
            .layerMaxXMaxYCorner,
        ]
    }

    static var right: CACornerMask {
        [
            .layerMaxXMinYCorner,
            .layerMaxXMaxYCorner,
        ]
    }
}
