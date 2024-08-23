//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public extension CGSize {
    var ceil: CGSize {
        .init(
            width: Foundation.ceil(width),
            height: Foundation.ceil(height)
        )
    }
}

public extension CGSize {
    func sizeThatFits(inside: CGSize) -> CGSize {
        guard width > 0 && height > 0 else { return inside }

        let sameWidth = CGSize(
            width: inside.width,
            height: height / width * inside.width
        )

        let sameHeight = CGSize(
            width: width / height * inside.height,
            height: inside.height
        )

        return sameHeight.height < sameWidth.height ? sameHeight : sameWidth
    }

    func scale(multiplier: CGFloat) -> CGSize {
        .init(width: width * multiplier, height: height * multiplier)
    }
}
