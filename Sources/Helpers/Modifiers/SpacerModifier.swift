//  Created by Thinh Nguyen
//

import SwiftUI

public struct SpacerModifier: ViewModifier {
  let space: CGFloat

  public func body(content: Content) -> some View {
    if space != 0.0 {
      content
      Spacer()
        .frame(height: space)
    } else {
      content
      Spacer()
    }
  }
}

struct SpacerModifier_Preview: PreviewProvider {
  static var previews: some View {
    HStack {
      Text("Hello World")
        .addSpace(with: 10, isVertical: true)
    }
    .padding(16)
    .previewable()
  }
}
