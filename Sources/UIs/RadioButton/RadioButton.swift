//  Created by Thinh Nguyen
//

import SwiftUI

// MARK: - RadioButton

public struct RadioButton: View {
  @EnvironmentObject var themeProvider: ThemeProvider
  @State var isPressed: Bool = false

  let isSelected: Bool
  let text: String?
  let enabled: Bool
  let action: () -> Void

  public init(
    isSelected: Bool,
    text: String?,
    enabled: Bool = true,
    action: @escaping () -> Void
  ) {
    self.isSelected = isSelected
    self.text = text
    self.enabled = enabled
    self.action = action
  }

  public var body: some View {
    Button(action: action, label: {
      HStack(spacing: 16, content: {
        let color = enabled ? themeProvider.currentTheme.colors.uiBackgroundPrimary : themeProvider.currentTheme.colors.uiBackgroundSecondary

        color
          .frame(width: 24, height: 24)
          .cornerRadius(12)
          .overlay {
            RoundedRectangle(cornerRadius: 12)
              .stroke(borderColor, lineWidth: borderWidth)
          }
        if let text {
          Text(text)
            .foregroundColor(themeProvider.currentTheme.colors.textPrimary)
            .font(themeProvider.currentTheme.fonts.body2)
        }
      })
    })
    .buttonStyle(
      MyButtonStyle(
        isPressed: $isPressed,
        colors: themeProvider.currentTheme.colors
      )
    )
    .disabled(!enabled)
  }

  var borderColor: Color {
    let colors = themeProvider.currentTheme.colors

    if !enabled {
      return colors.borderDisabled
    } else if isPressed {
      return colors.borderFocus
    } else if isSelected {
      return colors.uiAccent
    } else {
      return colors.border
    }
  }

  var borderWidth: CGFloat {
    if !enabled {
      return 1
    } else if isPressed {
      return 2
    } else if isSelected {
      return 6
    } else {
      return 1
    }
  }
}

// MARK: - RadioButton_Preview

struct RadioButton_Preview: PreviewProvider {
  static var previews: some View {
    VStack {
      RadioButton(
        isSelected: false,
        text: "Enabled",
        enabled: true,
        action: {}
      )

      RadioButton(
        isSelected: true,
        text: "Selected Enabled",
        enabled: true,
        action: {}
      )

      RadioButton(
        isSelected: false,
        text: "Disabled",
        enabled: false,
        action: {}
      )

      RadioButton(
        isSelected: true,
        text: "Selected Disabled",
        enabled: false,
        action: {}
      )

      RadioButton(
        isSelected: false,
        text: nil,
        enabled: true,
        action: {}
      )
    }
    .previewable()
  }
}
