//  Created by Thinh Nguyen
//

import Foundation

struct TThemeStandard: TTheme {
    var id: ThemeType { .standard }

    var fonts: TTypography = .english

    var colors: TColorsPalatte = .lightColorsPalette
}
