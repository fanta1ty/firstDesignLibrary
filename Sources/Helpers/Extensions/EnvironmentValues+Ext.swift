//  Created by Thinh Nguyen
//

import SwiftUI

public extension EnvironmentValues {
    var statusBarHeight: CGFloat {
        self[StatusBarHeightKey.self]
    }

    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }
}
