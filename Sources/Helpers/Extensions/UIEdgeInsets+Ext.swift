//  Created by Thinh Nguyen
//

import UIKit
import SwiftUI

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
