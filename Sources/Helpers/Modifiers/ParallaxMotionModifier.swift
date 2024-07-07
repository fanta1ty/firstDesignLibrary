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

struct ParallaxMotionModifier_Preview: PreviewProvider {
  static var previews: some View {
    Text("Test Parallax Motion Modifier")
      .addParallaxMotion(manager: .init(), magnitude: 20)
  }
}
