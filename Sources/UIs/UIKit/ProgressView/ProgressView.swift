//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public final class ProgressView: UIView {
    private let line = UIView()

    private var width: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?

    public var value: CGFloat {
        get {
            guard line.bounds.width > 0 else { return 0 }
            return bounds.width / line.bounds.width
        }
        set {
            width?.isActive = false
            width = line.widthAnchor
                .constraint(equalTo: widthAnchor, multiplier: newValue)
            width?.isActive = true
        }
    }

    public var height: CGFloat {
        get { heightConstraint?.constant ?? 0 }
        set { heightConstraint?.constant = newValue }
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        isUserInteractionEnabled = false
        backgroundColor = .uiBackgroundTertiary

        heightConstraint = heightAnchor
            .constraint(equalToConstant: 4)
        heightConstraint?.isActive = true

        line.isUserInteractionEnabled = false
        line.backgroundColor = .uiAccent
        line.translatesAutoresizingMaskIntoConstraints = false
        addSubview(line)

        line.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        line.topAnchor.constraint(equalTo: topAnchor).isActive = true
        line.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        width = line.widthAnchor
            .constraint(equalTo: widthAnchor, multiplier: 0)
        width?.isActive = true
    }

    public func set(
        value: CGFloat,
        animated: Bool,
        completion: (() -> Void)? = nil
    ) {
        if animated {
            layoutIfNeeded()
            self.value = value
            UIView.animate(withDuration: 0.3, animations: {
                self.layoutIfNeeded()
            }, completion: { _ in
                completion?()
            })
        } else {
            self.value = value
            completion?()
        }
    }
}
