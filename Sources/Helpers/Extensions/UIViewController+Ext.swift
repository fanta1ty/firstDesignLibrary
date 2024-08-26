//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public protocol ViewControllerWithTappableControlsUnderNavigationBar {
    var tappableControlsUnderNavigationbar: [UIView] { get }
}

public extension UIViewController {
    var statusBarHeight: CGFloat {
        navigationController?.navigationBar.frame.minY ?? 0
    }

    var isVisible: Bool {
        viewIfLoaded?.window != nil
    }

    var presentedViewControllers: [UIViewController] {
        if let presentedViewController {
            return [presentedViewController] + presentedViewController.presentedViewControllers
        } else { return [] }
    }

    var topPresentedOrVisibleViewControllerOrSelf: UIViewController {
        if let presentedViewController {
            return presentedViewController.topPresentedOrVisibleViewControllerOrSelf
        }

        if let nav = self as? UINavigationController,
           let visibleVC = nav.visibleViewController
        {
            return visibleVC.topPresentedOrVisibleViewControllerOrSelf
        }
        return self
    }
}

public extension UIViewController {
    func popOrDismiss(
        animated: Bool,
        completion: (() -> Void)? = nil
    ) {
        if let navigationController, navigationController.viewControllers.count > 1 {
            navigationController.popViewControllerWithCompletion(
                animated: animated,
                completion: completion
            )
        } else {
            dismiss(
                animated: animated,
                completion: completion
            )
        }
    }

    func dismissOrPop(animated: Bool, completion: (() -> Void)? = nil) {
        if presentingViewController != nil {
            dismiss(animated: animated, completion: completion)
        } else {
            popOrDismiss(animated: animated, completion: completion)
        }
    }

    func setNavigationProgress(
        value: Int,
        outOf total: Int,
        visible: Bool
    ) {
        let bar = navigationController?.navigationBar as? DesignNavigationBar
        bar?.set(progress: value, outOf: total, visible: visible)
    }

    func presentLoading() -> ModalLoadingView {
        let window = view.window ?? view
        let view = ModalLoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false

        guard let window else { return view }

        window.addSubview(view)
        view.leadingAnchor.constraint(equalTo: window.leadingAnchor)
            .isActive = true
        view.trailingAnchor.constraint(equalTo: window.trailingAnchor)
            .isActive = true
        view.topAnchor.constraint(equalTo: window.topAnchor)
            .isActive = true
        view.bottomAnchor.constraint(equalTo: window.bottomAnchor)
            .isActive = true

        window.layoutIfNeeded()

        UIView.animate(withDuration: 0.5, animations: {
            view.blur.alpha = 1
            view.animationContainer.alpha = 1
        })

        return view
    }
}

public extension UIViewController {
    static func instantiateWithStoryboard() -> Self {
        let name = String(describing: self)
            .replacingOccurrences(of: "ViewController", with: "")

        guard let viewController = UIStoryboard(name: name, bundle: nil)
            .instantiateInitialViewController()
        else {
            fatalError("Couldn't instantiate view controller with identifier")
        }

        return viewController as! Self
    }
}
