//  Created by Thinh Nguyen
//

import SwiftUI

struct StatusBarHeightKey: EnvironmentKey {
    static var defaultValue: CGFloat {
        UIApplication.shared
            .windowScene?
            .statusBarManager?
            .statusBarFrame.height ?? 0
    }
}
