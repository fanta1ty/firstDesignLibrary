//  Created by Thinh Nguyen
//

import Foundation

public class OpacityAnimationManager: ObservableObject {
    @Published var opacity: Double = 0.0

    public init(opacity: Double) {
        self.opacity = opacity
    }
}
