//  Created by Thinh Nguyen
//

import SwiftUI

public struct SecondaryRoundButton<Content: View>: View {
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
      buttonStyle: TButtonDefault.SecondaryRoundButtonStyle(
        isEnabled: enabled,
        theme: themeProvider.currentTheme
      ),
      buttonSize: TButtonDefault.secondaryRoundButtonSize(theme: themeProvider.currentTheme),
      enabled: enabled,
      action: action,
      content: content
    )
  }
}

struct SecondaryRoundButton_Previews: PreviewProvider {
  static var previews: some View {
    SecondaryRoundButton(
      action: {},
      content: {
        Text("Secondary Round Button")
      }
    ).previewable()
  }
}
