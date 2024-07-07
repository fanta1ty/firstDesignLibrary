//  Created by Thinh Nguyen
//

import SwiftUI

public struct PreviewableModifier: ViewModifier {
  public func body(content: Content) -> some View {
    content
      .environmentObject(
        ThemeProvider(currentTheme: TThemeStandard())
      )
  }
}

struct PreviewableModifier_Preview: PreviewProvider {
  static var previews: some View {
    Text("Test Previewable Modifier")
      .previewable()
  }
}
