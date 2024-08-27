//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public extension ThemeProvider {
    var light: ThemeProvider {
        .init(currentTheme: TThemeStandard(fonts: currentTheme.fonts, colors: .lightColorsPalette))
    }

    var dark: ThemeProvider {
        .init(currentTheme: TThemeStandard(fonts: currentTheme.fonts, colors: .darkColorsPalette))
    }
}
