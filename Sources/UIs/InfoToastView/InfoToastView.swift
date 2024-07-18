//  Created by Thinh Nguyen
//

import SwiftUI

// MARK: - InfoToastView

public struct InfoToastView: View {
  @EnvironmentObject var themeProvider: ThemeProvider

  public let title: String
  public let description: String?
  public let fillColor: Color
  public let leadingIcon: UIImage?
  public let trailingIcon: UIImage?
  public let hasBorder: Bool
  public let hasShadow: Bool
  public let padding: CGFloat
  public let textSpacing: CGFloat

  init(
    title: String,
    description: String?,
    fillColor: Color,
    leadingIcon: UIImage?,
    trailingIcon: UIImage?,
    hasBorder: Bool,
    hasShadow: Bool,
    padding: CGFloat = 20,
    textSpacing: CGFloat = 2
  ) {
    self.title = title
    self.description = description
    self.fillColor = fillColor
    self.leadingIcon = leadingIcon
    self.trailingIcon = trailingIcon
    self.hasBorder = hasBorder
    self.hasShadow = hasShadow
    self.padding = padding
    self.textSpacing = textSpacing
  }

  public var body: some View {
    CardView(fillColor: fillColor) {
      BasicListRowView {
        VStack {
          if let leadingIcon {
            Image(uiImage: leadingIcon)
              .foregroundColor(themeProvider.currentTheme.colors.icon)
              .frame(width: 24, height: 24)
          }
        }
      } centerContent: {
        RowItemContentView(
          subtitle: Text(title),
          desc: description != nil ? Text(description ?? "") : nil
        )
        .padding(.vertical, textSpacing)
      } trailingContent: {
        VStack {
          if let trailingIcon {
            Image(uiImage: trailingIcon)
              .frame(width: 24, height: 24)
          }
          Spacer()
        }
      }
      .padding(8)
    }
    .if(hasBorder) {
      $0.overlay {
        RoundedRectangle(cornerRadius: 8)
          .stroke(
            themeProvider.currentTheme.colors.borderSubtle,
            lineWidth: 1
          )
      }
    }
    .if(hasShadow) {
      $0.shadow(radius: 1)
    }
    .padding(padding)
    .fixedSize(horizontal: false, vertical: true)
  }
}

// MARK: - InfoToastView_Preview

struct InfoToastView_Preview: PreviewProvider {
  static var previews: some View {
    InfoToastView(
      title: "Toast Title",
      description: String(repeating: "Description", count: 12),
      fillColor: .clear,
      leadingIcon: .checkmark,
      trailingIcon: .checkmark,
      hasBorder: true,
      hasShadow: false
    )
    .previewable()
  }
}
