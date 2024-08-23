//  Created by Thinh Nguyen
//

import SwiftUI

struct ScratchMask: Shape {
    var points: [CGPoint]
    var startingPoint: CGPoint

    func path(in _: CGRect) -> Path {
        return Path { path in
            path.move(to: startingPoint)
            path.addLines(points)
        }
    }
}
