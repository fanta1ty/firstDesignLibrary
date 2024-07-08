//  Created by Thinh Nguyen
//

import SwiftUI

public struct PillButton<Content: View>: View {
  @EnvironmentObject var themeProvider: ThemeProvider
  @ViewBuilder let content: () -> Content

  let enabled: Bool
  let verticalPadding: CGFloat
  let action: () -> Void

  init(
    enabled: Bool = true,
    verticalPadding: CGFloat = 12,
    action: @escaping () -> Void,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.content = content
    self.verticalPadding = verticalPadding
    self.enabled = enabled
    self.action = action
  }

  public var body: some View {
    BaseButton(
      buttonStyle: TButtonDefault.PillRoundButtonStyle(
        isEnabled: enabled,
        theme: themeProvider.currentTheme
      ),
      buttonSize: TButtonDefault.pillButtonSize(
        theme: themeProvider.currentTheme,
        verticalPadding: verticalPadding
      ),
      enabled: enabled,
      action: action,
      content: content
    )
  }
}

struct PillButton_Previews: PreviewProvider {
  static var previews: some View {
    PillButton(
      action: {},
      content: {
        Text("Pill Button")
      }
    ).previewable()
  }
}
