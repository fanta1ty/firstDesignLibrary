//  Created by Thinh Nguyen
//

import SwiftUI

// MARK: - BaseButton

public struct BaseButton<Content: View, CustomButtonStyle: ButtonStyle>: View {
  @ViewBuilder let content: () -> Content

  let buttonStyle: CustomButtonStyle
  let buttonSize: ButtonSize
  let enabled: Bool
  let action: () -> Void

  public init(
    buttonStyle: CustomButtonStyle,
    buttonSize: ButtonSize,
    enabled: Bool,
    action: @escaping (() -> Void),
    @ViewBuilder content: @escaping () -> Content) {
    self.buttonStyle = buttonStyle
    self.buttonSize = buttonSize
    self.enabled = enabled
    self.action = action
    self.content = content
  }

  public var body: some View {
    Button(action: action, label: {
      content()
        .font(buttonSize.textSize)
        .padding([.leading, .trailing], buttonSize.horizontalPadding)
        .padding([.top, .bottom], buttonSize.verticalPadding)
        .contentShape(Rectangle())
    })
    .disabled(!enabled)
    .buttonStyle(buttonStyle)
  }
}
