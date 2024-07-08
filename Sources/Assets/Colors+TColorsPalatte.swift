//  Created by Thinh Nguyen
//

import SwiftUI

public struct TColorsPalatte {
  public let border: Color
  public let borderDisabled: Color
  public let borderFocus: Color
  public let borderNegative: Color
  public let borderPositive: Color
  public let borderSubtle: Color

  public let buttonOutline: Color
  public let buttonPrimary: Color
  public let buttonPrimaryDisabled: Color
  public let buttonPrimaryPressed: Color
  public let buttonSecondary: Color
  public let buttonSecondaryDisabled: Color
  public let buttonSecondaryPressed: Color
  public let buttonTertiary: Color
  public let buttonTertiaryLight: Color
  public let buttonTertiaryDisabled: Color
  public let buttonTertiaryPressed: Color
  public let buttonToggle: Color
  public let buttonToggleActive: Color
  public let buttonToggleDark: Color

  public let divider1: Color
  public let dividerActive2: Color

  public let icon: Color
  public let iconActive: Color
  public let iconLight: Color
  public let iconDark: Color
  public let iconDisabled: Color
  public let iconDisabledLight: Color
  public let iconInverse: Color
  public let iconInverseLight: Color

  public let primary: Color
  public let primaryVariant: Color

  public let statusInfo: Color
  public let statusInfoBackground: Color

  public let statusNegative: Color
  public let statusNegativeLight: Color
  public let statusNegativeBackground: Color
  public let statusNegativeBackgroundLight: Color

  public let statusPositive: Color
  public let statusPositiveBackground: Color
  public let statusPositiveBackgroundLight: Color

  public let statusWarning: Color
  public let statusWarningBackground: Color

  public let textBrand: Color

  public let textDisabled: Color

  public let textLink: Color
  public let textLinkLight: Color
  public let textLinkPressed: Color

  public let textNegative: Color
  public let textNegativeLight: Color

  public let textPositive: Color

  public let textPrimary: Color
  public let textPrimaryInverse: Color
  public let textPrimaryLight: Color
  public let textPrimaryDark: Color

  public let textSecondary: Color
  public let textSecondaryInverse: Color
  public let textSecondaryLight: Color
  public let textSecondaryDark: Color

  public let textTertiary: Color
  public let textTertiaryInverse: Color
  public let textTertiaryLight: Color
  public let textTertiaryDark: Color

  public let textWarning: Color
  public let textWarningLight: Color

  public let textInfo: Color

  public let ui: Color

  public let uiAccent: Color
  public let uiAccentLight: Color
  public let uiAccentPurple: Color
  public let uiAccentGreen: Color
  public let uiAccentRed: Color
  public let uiAccentOrange: Color
  public let uiAccentYellow: Color

  public let uiBackdrop: Color

  public let uiBackgroundPrimary: Color
  public let uiBackgroundPrimaryLight: Color
  public let uiBackgroundSecondary: Color
  public let uiBackgroundSecondaryLight: Color
  public let uiBackgroundTeriary: Color
  public let uiBackgroundViolet: Color

  public let uiBrand: Color

  public let uiPrimary: Color
  public let uiPrimaryDark: Color
  public let uiPrimaryLight: Color
  public let uiPrimary50: Color

  public let uiTransparent: Color

  public let tpBrandColor: Color
  public let tpBrandColorLight: Color
}

public extension TColorsPalatte {
  static let lightColorsPalette = TColorsPalatte(
    border: Color(.n500),
    borderDisabled: Color(.n300),
    borderFocus: Color(.pr600),
    borderNegative: Color(.r300),
    borderPositive: Color(.g500),
    borderSubtle: Color(.n50),
    buttonOutline: Color(.pr800),
    buttonPrimary: Color(.pr800),
    buttonPrimaryDisabled: Color(.n100),
    buttonPrimaryPressed: Color(.pr700),
    buttonSecondary: Color(.n0),
    buttonSecondaryDisabled: Color(.pr50),
    buttonSecondaryPressed: Color(.n100),
    buttonTertiary: Color(.pr800),
    buttonTertiaryLight: Color(.pr800),
    buttonTertiaryDisabled: Color(.pr50),
    buttonTertiaryPressed: Color(.pr500),
    buttonToggle: Color(.pr800),
    buttonToggleActive: Color(.g600),
    buttonToggleDark: Color(.pr800),
    divider1: Color(.n100),
    dividerActive2: Color(.pr500),
    icon: Color(.pr900),
    iconActive: Color(.pr500),
    iconLight: Color(.n0),
    iconDark: Color(.pr900),
    iconDisabled: Color(.n400),
    iconDisabledLight: Color(.n400),
    iconInverse: Color(.n0),
    iconInverseLight: Color(.n0),
    primary: Color(.pr500),
    primaryVariant: Color(.pr600),
    statusInfo: Color(.pr600),
    statusInfoBackground: Color(.pr50),
    statusNegative: Color(.r600),
    statusNegativeLight: Color(.r600),
    statusNegativeBackground: Color(.r50),
    statusNegativeBackgroundLight: Color(.r50),
    statusPositive: Color(.g600),
    statusPositiveBackground: Color(.g50),
    statusPositiveBackgroundLight: Color(.g50),
    statusWarning: Color(.o600),
    statusWarningBackground: Color(.o50),
    textBrand: Color(.pr500),
    textDisabled: Color(.n600),
    textLink: Color(.pr600),
    textLinkLight: Color(.pr600),
    textLinkPressed: Color(.pr700),
    textNegative: Color(.r600),
    textNegativeLight: Color(.r600),
    textPositive: Color(.g600),
    textPrimary: Color(.pr900),
    textPrimaryInverse: Color(.n0),
    textPrimaryLight: Color(.n0),
    textPrimaryDark: Color(.pr900),
    textSecondary: Color(.n700),
    textSecondaryInverse: Color(.n200),
    textSecondaryLight: Color(.n200),
    textSecondaryDark: Color(.n700),
    textTertiary: Color(.n500),
    textTertiaryInverse: Color(.n300),
    textTertiaryLight: Color(.n300),
    textTertiaryDark: Color(.n500),
    textWarning: Color(.o600),
    textWarningLight: Color(.o600),
    textInfo: Color(.r600),
    ui: Color(.n50),
    uiAccent: Color(.pr500),
    uiAccentLight: Color(.pr50),
    uiAccentPurple: Color(.pu500),
    uiAccentGreen: Color(.g500),
    uiAccentRed: Color(.r500),
    uiAccentOrange: Color(.o500),
    uiAccentYellow: Color(.y500),
    uiBackdrop: Color(.pr50),
    uiBackgroundPrimary: Color(.n0),
    uiBackgroundPrimaryLight: Color(.n0),
    uiBackgroundSecondary: Color(.n50),
    uiBackgroundSecondaryLight: Color(.n50),
    uiBackgroundTeriary: Color(.n100),
    uiBackgroundViolet: Color(.pu300),
    uiBrand: Color(.pr500),
    uiPrimary: Color(.pr800),
    uiPrimaryDark: Color(.pr800),
    uiPrimaryLight: Color(.n0),
    uiPrimary50: Color(.pr50),
    uiTransparent: Color(.n0.withAlphaComponent(0.0)),
    tpBrandColor: Color(.sd700),
    tpBrandColorLight: Color(.sd400)
  )

  static let darkColorsPalette = TColorsPalatte(
    border: Color(.n100),
    borderDisabled: Color(.n700),
    borderFocus: Color(.pr500),
    borderNegative: Color(.r300),
    borderPositive: Color(.g500),
    borderSubtle: Color(.n600),
    buttonOutline: Color(.n0),
    buttonPrimary: Color(.n0),
    buttonPrimaryDisabled: Color(.n900),
    buttonPrimaryPressed: Color(.pr500),
    buttonSecondary: Color(.pr800),
    buttonSecondaryDisabled: Color(.n900),
    buttonSecondaryPressed: Color(.pr700),
    buttonTertiary: Color(.n900),
    buttonTertiaryLight: Color(.pr800),
    buttonTertiaryDisabled: Color(.n900),
    buttonTertiaryPressed: Color(.n800),
    buttonToggle: Color(.pr800),
    buttonToggleActive: Color(.g500),
    buttonToggleDark: Color(.pr800),
    divider1: Color(.n800),
    dividerActive2: Color(.pr500),
    icon: Color(.n0),
    iconActive: Color(.pr500),
    iconLight: Color(.n0),
    iconDark: Color(.pr900),
    iconDisabled: Color(.n600),
    iconDisabledLight: Color(.n400),
    iconInverse: Color(.pr900),
    iconInverseLight: Color(.n0),
    primary: Color(.pr500),
    primaryVariant: Color(.pr600),
    statusInfo: Color(.pr500),
    statusInfoBackground: Color(.pr800),
    statusNegative: Color(.r500),
    statusNegativeLight: Color(.r50),
    statusNegativeBackground: Color(.r800),
    statusNegativeBackgroundLight: Color(.r50),
    statusPositive: Color(.g500),
    statusPositiveBackground: Color(.g800),
    statusPositiveBackgroundLight: Color(.g50),
    statusWarning: Color(.o500),
    statusWarningBackground: Color(.o800),
    textBrand: Color(.pr500),
    textDisabled: Color(.n300),
    textLink: Color(.pr400),
    textLinkLight: Color(.pr600),
    textLinkPressed: Color(.pr300),
    textNegative: Color(.r500),
    textNegativeLight: Color(.r600),
    textPositive: Color(.g500),
    textPrimary: Color(.n0),
    textPrimaryInverse: Color(.pr900),
    textPrimaryLight: Color(.n0),
    textPrimaryDark: Color(.pr900),
    textSecondary: Color(.n200),
    textSecondaryInverse: Color(.n700),
    textSecondaryLight: Color(.n200),
    textSecondaryDark: Color(.n700),
    textTertiary: Color(.n300),
    textTertiaryInverse: Color(.n500),
    textTertiaryLight: Color(.n300),
    textTertiaryDark: Color(.n500),
    textWarning: Color(.o500),
    textWarningLight: Color(.o600),
    textInfo: Color(.r500),
    ui: Color(.n950),
    uiAccent: Color(.pr500),
    uiAccentLight: Color(.pr700),
    uiAccentPurple: Color(.pu500),
    uiAccentGreen: Color(.g500),
    uiAccentRed: Color(.r500),
    uiAccentOrange: Color(.o500),
    uiAccentYellow: Color(.y500),
    uiBackdrop: Color(.pr950),
    uiBackgroundPrimary: Color(.n975),
    uiBackgroundPrimaryLight: Color(.n0),
    uiBackgroundSecondary: Color(.n950),
    uiBackgroundSecondaryLight: Color(.n50),
    uiBackgroundTeriary: Color(.n900),
    uiBackgroundViolet: Color(.pu300),
    uiBrand: Color(.pr500),
    uiPrimary: Color(.n0),
    uiPrimaryDark: Color(.pr800),
    uiPrimaryLight: Color(.n0),
    uiPrimary50: Color(.pr50),
    uiTransparent: Color(.n0.withAlphaComponent(0.0)),
    tpBrandColor: Color(.sd700),
    tpBrandColorLight: Color(.sd400)
  )
}
