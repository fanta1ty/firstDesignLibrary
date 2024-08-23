//  Created by Thinh Nguyen
//

import SwiftUI
import UIKit

extension UIEdgeInsets {
    var insets: EdgeInsets {
        EdgeInsets(
            top: top,
            leading: left,
            bottom: bottom,
            trailing: right
        )
    }
}
