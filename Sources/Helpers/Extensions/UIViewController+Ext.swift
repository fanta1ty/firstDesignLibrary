//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public extension UIViewController {
    var statusBarHeight: CGFloat {
        navigationController?.navigationBar.frame.minY ?? 0
    }

    var isVisible: Bool {
        viewIfLoaded?.window != nil
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
