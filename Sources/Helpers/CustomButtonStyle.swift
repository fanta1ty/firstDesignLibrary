//  Created by Thinh Nguyen
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
  let hasPressedState: Bool

  @ViewBuilder func makeBody(
    configuration: Configuration
  ) -> some View {
    configuration
      .label
      .if(hasPressedState) {
        $0.opacity(configuration.isPressed ? 0.5 : 1)
      }
  }
}
