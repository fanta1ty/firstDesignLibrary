//  Created by Thinh Nguyen
//

import Foundation
import SwiftUI
import UIKit

public extension UINavigationController {
    func push(
        viewController: UIViewController,
        removing: UIViewController?,
        animated: Bool
    ) {
        var stack = viewControllers
        stack.removeAll { $0 === removing }
        stack.append(viewController)
        setViewControllers(stack, animated: animated)
    }

    func push(viewControllerRemovingAllButRoot vc: UIViewController) {
        var stack = Array(viewControllers.prefix(1))
        stack.append(vc)
        setViewControllers(stack, animated: true)
    }

    func push<T: View>(viewController: UIViewController, removingTo view: T.Type) {
        var stack = viewControllers
        while true, stack.count > 1 {
            guard let last = stack.last else { break }
            if last.description.contains(String(describing: view)) { break }
            _ = stack.popLast()
        }

        stack.append(viewController)
        setViewControllers(stack, animated: true)
    }

    func push(viewController: UIViewController, removingTo vc: UIViewController.Type) {
        var stack = viewControllers(popTo: vc)
        stack.append(viewController)
        setViewControllers(stack, animated: true)
    }

    func popTo(vc: UIViewController.Type) {
        let stack = viewControllers(popTo: vc)
        setViewControllers(stack, animated: true)
    }

    func popViewControllerWithCompletion(animated: Bool, completion: (() -> Void)? = nil) {
        popViewController(animated: animated)

        if animated, let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion?()
            }
        } else {
            completion?()
        }
    }
}

extension UINavigationController {
    func viewControllers(popTo vc: UIViewController.Type) -> [UIViewController] {
        var stack = viewControllers
        while true, stack.count > 1 {
            guard let last = stack.last else { break }
            if last.isKind(of: vc) { break }
            _ = stack.popLast()
        }
        return stack
    }
}
