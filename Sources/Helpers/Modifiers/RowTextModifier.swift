//  Created by Thinh Nguyen
//

import SwiftUI

public struct RowTextModifier: ViewModifier {
  let type: RowTextType
  let theme: any TTheme

  public func body(content: Content) -> some View {
    HStack {
      switch type {
      case .title, .desc:
        content
          .font(theme.fonts.body3)
          .foregroundColor(theme.colors.textTertiary)
          .frame(alignment: .leading)

      case .subtitle:
        content
          .font(theme.fonts.body2)
          .foregroundColor(theme.colors.textPrimary)
          .frame(alignment: .leading)

      case .link:
        content
          .font(theme.fonts.link1)
          .foregroundColor(theme.colors.textLink)
          .frame(alignment: .leading)
      }
    }
  }
}

struct RowTextModifier_Preview: PreviewProvider {
  static var previews: some View {
    let theme = TThemeStandard()

    return VStack {
      Text("Test Row Text Modifier - Type Title")
        .config(for: .title, in: theme)
      Text("Test Row Text Modifier - Type Subtitle")
        .config(for: .subtitle, in: theme)
      Text("Test Row Text Modifier - Type Desc")
        .config(for: .desc, in: theme)
      Text("Test Row Text Modifier - Type Link")
        .config(for: .link, in: theme)
    }
    .padding(16)
  }
}
