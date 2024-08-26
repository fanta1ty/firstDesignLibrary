//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public final class DesignNavigationBar: UINavigationBar {
    public let progress = StepperView()
    public var lineBackgroundColor: UIColor = .uiBackgroundPrimary

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        progress.alpha = 0
        progress.lineBackgroundColor = lineBackgroundColor
        progress.translatesAutoresizingMaskIntoConstraints = false
        addSubview(progress)

        progress.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24)
            .isActive = true
        progress.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
            .isActive = true
        progress.bottomAnchor.constraint(equalTo: bottomAnchor)
            .isActive = true
    }

    public func set(
        progress value: Int,
        outOf total: Int,
        visible: Bool
    ) {
        if visible {
            progress.lineBackgroundColor = lineBackgroundColor
            progress.set(progress: value, outOf: total)
        }

        UIView.animate(withDuration: 0.3, animations: { [progress] in
            progress.alpha = visible ? 1 : 0
        }, completion: visible ? nil : { [progress] success in
            if success {
                progress.clear()
            }
        })
    }

    override public func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let vc = navigationControllerViaResponders?.visibleViewController as? ViewControllerWithTappableControlsUnderNavigationBar
        let tappableControlsUnderNavigationbar = vc?.tappableControlsUnderNavigationbar ?? []

        for view in tappableControlsUnderNavigationbar {
            let convertedPoint = view.convert(point, from: self)
            if view.point(inside: convertedPoint, with: event) { return false }
        }
        return super.point(inside: point, with: event)
    }
}
