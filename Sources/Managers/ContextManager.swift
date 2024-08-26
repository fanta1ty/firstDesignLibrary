//  Created by Thinh Nguyen
//

import Foundation

public final class ContextManager {
    public static let shared = ContextManager()

    public lazy var localiseManager = LocaliseManager()
    public lazy var repositoryManager = RepositoryManager()
    public lazy var navigationManager = NavigationManager()
    public lazy var startupManager = StartupManager()
    public lazy var themeManager = ThemeManager()
}
