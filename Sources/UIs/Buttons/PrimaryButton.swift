//  Created by Thinh Nguyen
//

import SwiftUI

public struct PrimaryButton<Content: View>: View {
  @EnvironmentObject var themeProvider: ThemeProvider
  @ViewBuilder let content: () -> Content

  let enabled: Bool
  let action: () -> Void

  init(
    enabled: Bool = true,
    action: @escaping () -> Void,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.content = content
    self.enabled = enabled
    self.action = action
  }

  public var body: some View {
    BaseButton(
      buttonStyle: TButtonDefault.PrimaryButtonStyle(
        isEnabled: enabled,
        theme: themeProvider.currentTheme
      ),
      buttonSize: TButtonDefault.regularButtonSize(theme: themeProvider.currentTheme),
      enabled: enabled,
      action: action,
      content: content
    )
  }
}

struct PrimaryButton_Previews: PreviewProvider {
  static var previews: some View {
    PrimaryButton(
      action: {},
      content: {
        Text("Primary Button")
      }
    ).previewable()
  }
}
