//  Created by Thinh Nguyen
//

import SwiftUI

public struct DividerModifier: ViewModifier {
  let color: Color

  public func body(content: Content) -> some View {
    VStack {
      content
      Divider()
        .background(color)
    }
  }
}

struct DividerModifier_Preview: PreviewProvider {
  static var previews: some View {
    HStack {
      Text("Hello World!!")
        .addDivider(with: .blue)
    }
    .padding(16)
  }
}
