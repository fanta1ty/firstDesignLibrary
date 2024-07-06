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
