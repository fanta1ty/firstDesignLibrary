//  Created by Thinh Nguyen
//

import Foundation
import SwiftUI
import UIKit

public final class NavigationManager: NSObject {
    let rootViewController: UINavigationController

    public var rootViewControllerOnlyForUseBySceneDelegate: UIViewController {
        rootViewController
    }

    public var topViewController: UIViewController {
        rootViewController.topPresentedOrVisibleViewControllerOrSelf
    }

    public weak var rootWindow: UIWindow?

    override public convenience init() {
        let root = LoadingViewController()
        let nav = RootNavigationController.designNav(rootVC: root)
        nav.isNavigationBarHidden = true
        self.init(rootViewController: nav)
    }

    public init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
        super.init()
    }
}
