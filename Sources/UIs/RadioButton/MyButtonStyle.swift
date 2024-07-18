//  Created by Thinh Nguyen
//

import SwiftUI

struct MyButtonStyle: ButtonStyle {
  @Binding var isPressed: Bool

  let colors: TColorsPalatte

  @ViewBuilder func makeBody(
    configuration: Configuration
  ) -> some View {
    configuration.label
      .onChange(of: configuration.isPressed, perform: { value in
        isPressed = value
      })
  }
}
