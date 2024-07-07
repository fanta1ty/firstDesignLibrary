//  Created by Thinh Nguyen
//

import SwiftUI

public struct TextModifier: ViewModifier {
  let font: Font
  let color: Color

  public func body(content: Content) -> some View {
    HStack {
      content
        .font(font)
        .foregroundColor(color)
    }
  }
}

struct TextModifier_Preview: PreviewProvider {
  static var previews: some View {
    let theme: TThemeStandard = TThemeStandard()

    return VStack {
      Text("Test Text Modifier - Body Light")
        .asBodyLight(in: theme)
      Text("Test Text Modifier - Body Dark")
        .asBodyDark(in: theme)
      Text("Test Text Modifier - Heading 2 Dark")
        .asHeading2Dark(in: theme)
      Text("Test Text Modifier - Heading 2 Dark")
        .asTextLinkTitle(in: theme)
    }
    .padding(16)
  }
}
