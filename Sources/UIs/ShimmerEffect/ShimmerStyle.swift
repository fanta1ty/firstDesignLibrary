//  Created by Thinh Nguyen
//

import Foundation
import SwiftUI

// MARK: - ShimmerStyle

public enum ShimmerStyle {
  case shimmer, bling
}

extension ShimmerStyle {
  var animation: Animation {
    switch self {
    case .shimmer: return ShimmerModifier.defaultAnimation
    case .bling: return ShimmerModifier.blingAnimation
    }
  }

  var gradient: Gradient {
    switch self {
    case .shimmer: return ShimmerModifier.defaultGradient
    case .bling: return ShimmerModifier.blingGradient
    }
  }

  var bandSize: CGFloat {
    return 0.3
  }
}
