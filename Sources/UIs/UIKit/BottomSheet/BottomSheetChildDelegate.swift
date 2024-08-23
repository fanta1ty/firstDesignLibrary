//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public protocol BottomSheetChildDelegate: AnyObject {
    func didUpdate(
        child: BottomSheetChild,
        height: CGFloat
    )
}
