//  Created by Thinh Nguyen
//

import Foundation

public final class LocaliseManager {
    public var didSetup: Bool = false

    public var language: Language? {
        get {
            guard let rawValue = ContextManager.shared.repositoryManager.localiseLanguage.value else {
                return nil
            }
            return Language(rawValue: rawValue)
        }
        set {
            ContextManager.shared.repositoryManager.localiseLanguage.value = newValue?.rawValue
            if let newValue {
                UserDefaults.default.set(
                    [newValue.rawValue],
                    forKey: UserDefaults.Keys.appleLanguages.rawValue
                )
            } else {
                UserDefaults.default.removeObject(forKey: UserDefaults.Keys.appleLanguages.rawValue)
            }
            UserDefaults.default.synchronize()
            setLanguage(language: language)
        }
    }

    public func startup() {}
}

extension LocaliseManager {
    private func setLanguage(language: LocaliseManager.Language?) {
        let myLang = language ?? Locale.current.language
        switch myLang {
        case .english, .none:
            ContextManager.shared.themeManager.themeProvider.currentTheme.fonts = .english
        case .chinese:
            ContextManager.shared.themeManager.themeProvider.currentTheme.fonts = .chinese
        }
    }
}
