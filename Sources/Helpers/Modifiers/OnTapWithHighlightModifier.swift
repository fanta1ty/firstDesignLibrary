//  Created by Thinh Nguyen
//

import SwiftUI

public struct OnTapWithHighlightModifier: ViewModifier {
  let onTap: () -> Void
  let isHaptic: Bool
  let hasPressedState: Bool

  public func body(
    content: Content
  ) -> some View {
    Button(action: {
      onTap()
      if isHaptic {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
      }
    }, label: {
      content
    })
    .buttonStyle(CustomButtonStyle(
      hasPressedState: hasPressedState)
    )
  }
}

struct OnTapWithHighlight_Previews: PreviewProvider {
  static var previews: some View {
    HStack {
      Text("Tap Me")
      Spacer()
      Text("Hello World")
    }
    .padding()
    .background(.yellow)
    .onTapWithHighLight { }
  }
}
