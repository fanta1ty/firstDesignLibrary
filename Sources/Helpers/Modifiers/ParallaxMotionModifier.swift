//  Created by Thinh Nguyen
//

import SwiftUI

public struct ParallaxMotionModifier: ViewModifier {
  @ObservedObject var manager: MotionManager

  var magnitude: Double

  public func body(content: Content) -> some View {
    content
      .offset(
        x: CGFloat(manager.roll * magnitude),
        y: CGFloat(manager.pitch * magnitude)
      )
  }
}
