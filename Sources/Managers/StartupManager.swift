//  Created by Thinh Nguyen
//

import Combine
import Foundation
import UIKit

public final class StartupManager {
    @Published public var isReady: Bool = false
    @Published public var error: Error?

    public let startupTimestamp = Date()

    @MainActor public func startup(
        launchOptions _: [UIApplication.LaunchOptionsKey: Any]?
    ) {
        ContextManager.shared.repositoryManager.startup()
        ContextManager.shared.localiseManager.startup()

        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.body2,
        ]

        UINavigationBar.appearance().standardAppearance = appearance
        UIBarButtonItem.appearance().setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.body2,
        ], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.body2,
        ], for: .highlighted)

        reload()
    }

    @MainActor public func reload() {
        isReady = false
        Task {
            error = nil

            do {
                try await reload()
                isReady = true
            } catch {
                self.error = error
            }
        }
    }

    @MainActor public func reload() async throws {}
}
