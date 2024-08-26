//  Created by Thinh Nguyen
//

import Foundation

public extension NavigationManager {
    var isDarkMode: Bool {
        rootWindow?.traitCollection.userInterfaceStyle == .dark
    }
}

public extension NavigationManager {
    func dismissAllPresentedViewControllers(
        animated: Bool,
        completion: (() -> Void)? = nil
    ) {
        let presentedCount = rootViewController.presentedViewControllers.count

        guard presentedCount > 0 else {
            completion?()
            return
        }

        for (i, vc) in rootViewController.presentedViewControllers.reversed().enumerated() {
            vc.dismiss(animated: animated, completion: i == presentedCount - 1 ? completion : nil)
        }
    }

    func hideRootNavigationBar(animated: Bool) {
        rootViewController.setNavigationBarHidden(true, animated: animated)
    }
}
