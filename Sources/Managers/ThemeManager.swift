//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public final class ThemeManager {
    public let themeProvider = ThemeProvider(currentTheme: TThemeStandard(fonts: .english, colors: .lightColorsPalette))

    public var interfaceStyle: UIUserInterfaceStyle {
        get {
            guard let rawValue = ContextManager.shared.repositoryManager.interfaceStyle.value,
                  let style = UIUserInterfaceStyle(rawValue: rawValue)
            else {
                return .unspecified
            }
            return style
        }
        set {
            ContextManager.shared.repositoryManager.interfaceStyle.value = newValue.rawValue
            updateAppTheme()
        }
    }
}

public extension ThemeManager {
    func updateAppTheme() {
        let interface = interfaceStyle

        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap(\.windows)
            .forEach { $0.overrideUserInterfaceStyle = interface }

        updateThemeProvider(with: interface)
    }

    func updateThemeProvider(with interface: UIUserInterfaceStyle) {
        switch interface {
        case .unspecified:
            updateThemeProviderBySystem()
        case .light:
            themeProvider.currentTheme.colors = .lightColorsPalette
        case .dark:
            themeProvider.currentTheme.colors = .darkColorsPalette
        @unknown default:
            updateThemeProviderBySystem()
        }
    }
}

extension ThemeManager {
    private func updateThemeProviderBySystem() {
        let isDarkMode = ContextManager.shared.navigationManager.isDarkMode
        themeProvider.currentTheme.colors = isDarkMode ? .darkColorsPalette : .lightColorsPalette
    }
}
