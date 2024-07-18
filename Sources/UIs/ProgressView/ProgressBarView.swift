//  Created by Thinh Nguyen
//

import SwiftUI

// MARK: - ProgressBarView

public struct ProgressBarView: View {
  @EnvironmentObject var themeProvider: ThemeProvider

  let progress: Double
  let tintColor: Color?
  let backgroundColor: Color?

  public init(
    progress: Double,
    tintColor: Color? = nil,
    backgroundColor: Color? = nil
  ) {
    self.progress = progress
    self.tintColor = tintColor
    self.backgroundColor = backgroundColor
  }

  public var body: some View {
    RoundedRectangle(cornerRadius: 4)
      .foregroundStyle(backgroundColor ?? themeProvider.currentTheme.colors.uiBackgroundTeriary)
      .overlay(alignment: .leading) {
        GeometryReader(content: { geometry in
          RoundedRectangle(cornerRadius: 4)
            .foregroundStyle(tintColor ?? themeProvider.currentTheme.colors.statusPositive)
            .frame(width: progress * geometry.size.width)
        })
      }
  }
}

// MARK: - ProgressBarView_Preview

struct ProgressBarView_Preview: PreviewProvider {
  static var previews: some View {
    VStack {
      ProgressBarView(
        progress: 0
      )
      .frame(height: 4)

      ProgressBarView(
        progress: 0.5,
        tintColor: .red,
        backgroundColor: .gray
      )
      .frame(height: 4)

      ProgressBarView(
        progress: 0.8,
        tintColor: .blue,
        backgroundColor: .red
      )
      .frame(height: 4)

      ProgressBarView(
        progress: 1
      )
      .frame(height: 4)
    }
    .previewable()
  }
}
