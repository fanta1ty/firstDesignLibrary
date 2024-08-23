//  Created by Thinh Nguyen
//

import SwiftUI

struct SafeAreaInsetsKey: EnvironmentKey {
    static var defaultValue: EdgeInsets {
        (UIApplication.shared
            .sceneKeyWindow?
            .safeAreaInsets ?? .zero).insets
    }
}
