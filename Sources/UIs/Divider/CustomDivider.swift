//  Created by Thinh Nguyen
//

import SwiftUI

// MARK: - CustomDivider

public struct CustomDivider: View {
  @EnvironmentObject var themeProvider: ThemeProvider

  let color: Color?
  let height: CGFloat?

  init(
    color: Color? = nil,
    height: CGFloat? = nil
  ) {
    self.color = color
    self.height = height
  }

  public var body: some View {
    Rectangle()
      .fill(color ?? themeProvider.currentTheme.colors.divider1)
      .frame(height: height ?? 1)
      .edgesIgnoringSafeArea(.horizontal)
  }
}

// MARK: - CustomDivider_Preview

struct CustomDivider_Preview: PreviewProvider {
  static var previews: some View {
    CustomDivider()
      .previewable()
  }
}
