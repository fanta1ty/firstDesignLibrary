//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public extension UIStackView {
    func set(arrangedSubviews newViews: [UIView]) {
        for v in arrangedSubviews {
            removeArrangedSubview(v)
            v.removeFromSuperview()
        }

        for v in newViews {
            addArrangedSubview(v)
        }
    }

    @discardableResult
    func addArrangedSubviews(_ views: UIView...) -> Self {
        addArrangedSubviews(views)
        return self
    }

    @discardableResult
    func addArrangedSubviews(_ views: [UIView]) -> Self {
        views.forEach(addArrangedSubview)
        return self
    }
}
