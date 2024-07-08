//  Created by Thinh Nguyen
//

import SwiftUI
import UIKit

// MARK: - TButtonDefault

enum TButtonDefault {
  static func regularButtonSize(
    theme: any TTheme
  ) -> ButtonSize {
    ButtonSize(
      verticalPadding: 12,
      horizontalPadding: 16,
      textSize: theme.fonts.body2
    )
  }

  static func smallButtonSize(
    theme: any TTheme
  ) -> ButtonSize {
    ButtonSize(
      verticalPadding: 8,
      horizontalPadding: 12,
      textSize: theme.fonts.body3
    )
  }

  static func primaryRoundButtonSize(
    theme: any TTheme
  ) -> ButtonSize {
    ButtonSize(
      verticalPadding: 12,
      horizontalPadding: 12,
      textSize: nil
    )
  }

  static func secondaryRoundButtonSize(
    theme: any TTheme
  ) -> ButtonSize {
    ButtonSize(
      verticalPadding: 8,
      horizontalPadding: 8,
      textSize: nil
    )
  }

  static func pillButtonSize(
    theme: any TTheme,
    verticalPadding: CGFloat
  ) -> ButtonSize {
    ButtonSize(
      verticalPadding: verticalPadding,
      horizontalPadding: 12,
      textSize: theme.fonts.body3
    )
  }

  static func chipsButtonSize(
    theme: any TTheme
  ) -> ButtonSize {
    ButtonSize(
      verticalPadding: 4,
      horizontalPadding: 8,
      textSize: theme.fonts.body3
    )
  }

  static func formButtonSize(
    theme: any TTheme
  ) -> ButtonSize {
    ButtonSize(
      verticalPadding: 20,
      horizontalPadding: 16,
      textSize: theme.fonts.body2
    )
  }

  static func roundBorderStyle(
    theme: any TTheme
  ) -> BorderStyle {
    BorderStyle(
      borderWidth: 0,
      borderColor: theme.colors.buttonOutline
    )
  }

  static func pillBorderStyle(
    theme: any TTheme
  ) -> BorderStyle {
    BorderStyle(
      borderWidth: 0,
      borderColor: theme.colors.buttonOutline
    )
  }

  static func chipsBorderStyle(
    theme: any TTheme
  ) -> BorderStyle {
    BorderStyle(
      borderWidth: 0,
      borderColor: theme.colors.buttonOutline
    )
  }

  static func primaryBorderStyle(
    theme: any TTheme
  ) -> BorderStyle {
    BorderStyle(
      borderWidth: 0,
      borderColor: theme.colors.buttonOutline
    )
  }

  static func secondaryBorderStyle(
    theme: any TTheme
  ) -> BorderStyle {
    BorderStyle(
      borderWidth: 1,
      borderColor: theme.colors.buttonOutline
    )
  }

  static func textBorderStyle(
    theme: any TTheme
  ) -> BorderStyle {
    BorderStyle(
      borderWidth: 0,
      borderColor: theme.colors.buttonOutline
    )
  }

  static func formBorderStyle(
    theme: any TTheme
  ) -> BorderStyle {
    BorderStyle(
      borderWidth: 0,
      borderColor: theme.colors.buttonOutline
    )
  }
}

extension TButtonDefault {
  struct PrimaryRoundButtonStyle: ButtonStyle {
    let isEnabled: Bool
    let theme: any TTheme

    @ViewBuilder func makeBody(configuration: Configuration) -> some View {
      let backgroundColor = isEnabled ? theme.colors.buttonPrimary : theme.colors.buttonPrimaryDisabled
      let pressedColor = theme.colors.buttonPrimaryPressed
      let buttonColor = configuration.isPressed ? pressedColor : backgroundColor
      let textColor = theme.colors.iconInverse

      configuration.label
        .background(buttonColor)
        .foregroundColor(textColor)
        .cornerRadius(48)
    }
  }

  struct SecondaryRoundButtonStyle: ButtonStyle {
    let isEnabled: Bool
    let theme: any TTheme

    @ViewBuilder func makeBody(configuration: Configuration) -> some View {
      let backgroundColor = isEnabled ? theme.colors.buttonSecondary : theme.colors.buttonSecondaryDisabled
      let pressedColor = theme.colors.buttonSecondaryPressed
      let buttonColor = configuration.isPressed ? pressedColor : backgroundColor
      let textColor = theme.colors.textPrimary

      configuration.label
        .background(buttonColor)
        .foregroundColor(textColor)
        .cornerRadius(48)
    }
  }

  struct PillRoundButtonStyle: ButtonStyle {
    let isEnabled: Bool
    let theme: any TTheme

    @ViewBuilder func makeBody(configuration: Configuration) -> some View {
      let backgroundColor = isEnabled ? theme.colors.buttonSecondary : theme.colors.buttonSecondaryDisabled
      let pressedColor = theme.colors.buttonSecondaryPressed
      let buttonColor = configuration.isPressed ? pressedColor : backgroundColor
      let textColor = theme.colors.textPrimary

      configuration.label
        .background(buttonColor)
        .foregroundColor(textColor)
        .cornerRadius(40)
    }
  }

  struct ChipsButtonStyle: ButtonStyle {
    let isEnabled: Bool
    let isSelected: Bool
    let theme: any TTheme

    @ViewBuilder func makeBody(configuration: Configuration) -> some View {
      var colors: (textColor: Color, backgroundColor: Color) {
        if configuration.isPressed {
          return (theme.colors.textPrimaryLight, theme.colors.uiAccent)
        } else if isSelected {
          return (theme.colors.textPrimaryInverse, theme.colors.buttonPrimary)
        } else if isEnabled {
          return (theme.colors.textPrimary, theme.colors.uiBackgroundSecondary)
        } else {
          return (theme.colors.textTertiary, theme.colors.uiBackgroundSecondary)
        }
      }

      configuration.label
        .background(colors.backgroundColor)
        .foregroundColor(colors.textColor)
        .cornerRadius(8)
    }
  }

  struct PrimaryButtonStyle: ButtonStyle {
    let isEnabled: Bool
    let theme: any TTheme

    @ViewBuilder func makeBody(configuration: Configuration) -> some View {
      let backgroundColor = isEnabled ? theme.colors.buttonPrimary : theme.colors.buttonPrimaryDisabled
      let pressedColor = theme.colors.buttonPrimaryPressed
      let buttonColor = configuration.isPressed ? pressedColor : backgroundColor
      let textColor = isEnabled ? theme.colors.textPrimaryInverse : theme.colors.textTertiary

      configuration.label
        .background(buttonColor)
        .foregroundColor(textColor)
        .cornerRadius(4)
    }
  }

  struct SecondaryButtonStyle: ButtonStyle {
    let isEnabled: Bool
    let theme: any TTheme

    @ViewBuilder func makeBody(configuration: Configuration) -> some View {
      let backgroundColor = isEnabled ? nil : theme.colors.buttonSecondaryDisabled
      let pressedColor = theme.colors.buttonSecondaryPressed
      let buttonColor = configuration.isPressed ? pressedColor : backgroundColor
      let textColor = isEnabled ? theme.colors.textPrimary : theme.colors.textTertiary

      configuration.label
        .background(buttonColor)
        .foregroundColor(textColor)
        .overlay(
          RoundedRectangle(cornerRadius: 4)
            .stroke(TButtonDefault.secondaryBorderStyle(theme: theme).borderColor,
                    lineWidth: TButtonDefault.secondaryBorderStyle(theme: theme).borderWidth)
        )
    }
  }

  struct TextButtonStyle: ButtonStyle {
    let isEnabled: Bool
    let theme: any TTheme

    @ViewBuilder func makeBody(configuration: Configuration) -> some View {
      let backgroundColor = isEnabled ? theme.colors.uiTransparent : theme.colors.buttonSecondaryDisabled
      let pressedColor = theme.colors.buttonSecondaryPressed
      let buttonColor = configuration.isPressed ? pressedColor : backgroundColor
      let textColor = isEnabled ? theme.colors.textSecondary : theme.colors.textTertiary

      configuration.label
        .background(buttonColor)
        .foregroundColor(textColor)
        .cornerRadius(4)
    }
  }

  struct FormButtonStyle: ButtonStyle {
    let isEnabled: Bool
    let theme: any TTheme

    @ViewBuilder func makeBody(configuration: Configuration) -> some View {
      let backgroundColor = isEnabled ? theme.colors.buttonPrimary : theme.colors.buttonPrimaryDisabled
      let pressedColor = theme.colors.buttonPrimaryPressed
      let buttonColor = configuration.isPressed ? pressedColor : backgroundColor
      let textColor = isEnabled ? theme.colors.textPrimaryInverse : theme.colors.textTertiary

      configuration.label
        .background(buttonColor)
        .foregroundColor(textColor)
    }
  }

  struct PrimaryGradientStyle: ButtonStyle {
    let isEnabled: Bool
    let theme: any TTheme

    @ViewBuilder func makeBody(configuration: Configuration) -> some View {
      let textColor = isEnabled ? theme.colors.textPrimaryDark : theme.colors.textTertiary

      configuration.label
        .background(
          LinearGradient(
            gradient: Gradient(
              colors: [
                theme.colors.uiAccentOrange,
                theme.colors.uiAccentYellow
              ]
            ),
            startPoint: .top,
            endPoint: .bottom
          )
        )
        .foregroundColor(textColor)
        .cornerRadius(4)
    }
  }
}
