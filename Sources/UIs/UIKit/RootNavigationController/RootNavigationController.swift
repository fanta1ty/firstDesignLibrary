//  Created by Thinh Nguyen
//

import Combine
import Foundation
import UIKit

public final class RootNavigationController: UINavigationController {
    public var cancellables: [AnyCancellable] = []
    public var isLockedToCurrentChild: Bool = false

    private var hasViewAppeared: Bool = false

    override public func viewDidLoad() {
        super.viewDidLoad()
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard !hasViewAppeared else { return }
        hasViewAppeared = true
    }

    override public var viewControllers: [UIViewController] {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }

    override public func pushViewController(_ viewController: UIViewController, animated: Bool) {
        guard !isLockedToCurrentChild else { return }
        super.pushViewController(viewController, animated: animated)
    }

    override public func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        guard !isLockedToCurrentChild else { return }
        super.setViewControllers(viewControllers, animated: animated)
    }

    override public func popViewController(animated: Bool) -> UIViewController? {
        return super.popViewController(animated: animated)
    }

    override public func popToRootViewController(animated: Bool) -> [UIViewController]? {
        return super.popToRootViewController(animated: animated)
    }

    override public func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        guard !isLockedToCurrentChild else { return }
        present(viewControllerToPresent, animated: flag, completion: completion)
    }
}
