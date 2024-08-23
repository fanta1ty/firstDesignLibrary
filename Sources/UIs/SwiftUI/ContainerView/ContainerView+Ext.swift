//  Created by Thinh Nguyen
//

import SwiftUI

public extension ContainerView {
    init(@ViewBuilder _ content: @escaping () -> Content) {
        self.init(content: content)
    }
}
