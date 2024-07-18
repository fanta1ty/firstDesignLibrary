//  Created by Thinh Nguyen
//

import SwiftUI

// MARK: - ChipView

public struct ChipView: View {
  @EnvironmentObject var themeProvider: ThemeProvider
  @State var isSelected: Bool = false

  let title: String
  let backgroundColor: Color
  let borderColor: Color
  let titleFont: Font
  let titleColor: Color
  let customVerticalPadding: CGFloat

  init(
    title: String,
    backgroundColor: Color,
    borderColor: Color,
    titleFont: Font,
    titleColor: Color,
    customVerticalPadding: CGFloat = 0
  ) {
    self.title = title
    self.backgroundColor = backgroundColor
    self.borderColor = borderColor
    self.titleFont = titleFont
    self.titleColor = titleColor
    self.customVerticalPadding = customVerticalPadding
  }

  public var body: some View {
    HStack {
      Text(title)
        .font(titleFont).lineLimit(1)
        .foregroundColor(titleColor)
    }
    .padding(.vertical, customVerticalPadding)
    .padding(.horizontal, 8)
    .background(backgroundColor)
    .cornerRadius(12)
    .overlay(RoundedRectangle(cornerRadius: 12)
      .stroke(borderColor, lineWidth: 0.5)
    )
    .onTapGesture {
      isSelected.toggle()
    }
  }
}

// MARK: - ChipView_Preview

struct ChipView_Preview: PreviewProvider {
  static var previews: some View {
    ChipView(
      title: "Title",
      backgroundColor: .gray,
      borderColor: .white,
      titleFont: .body,
      titleColor: .black
    )
    .cornerRadius(12)
    .allowsHitTesting(false)
    .previewable()
  }
}
