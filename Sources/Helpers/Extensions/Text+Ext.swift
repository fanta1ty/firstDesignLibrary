//  Created by Thinh Nguyen
//


import SwiftUI

public extension Text {
  func asBodyLight(
    in theme: any TTheme
  ) -> some View {
    modifier(TextModifier(
      font: theme.fonts.body1,
      color: theme.colors.textPrimaryLight
    ))
  }

  func asBodyDark(
    in theme: any TTheme
  ) -> some View {
    modifier(TextModifier(
      font: theme.fonts.body1,
      color: theme.colors.textPrimaryDark
    ))
  }

  func asHeading2Dark(
    in theme: any TTheme
  ) -> some View {
    modifier(TextModifier(
      font: theme.fonts.heading2,
      color: theme.colors.textPrimaryDark
    ))
  }

  func asTextLinkTitle(
    in theme: any TTheme
  ) -> some View {
    modifier(TextModifier(
      font: theme.fonts.body2Strong,
      color: theme.colors.textLink
    ))
  }
}
