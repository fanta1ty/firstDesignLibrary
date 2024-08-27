//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public final class DotView: UIView {
    private let expandRate: CGFloat = 2.0
    private let animationDuration: CGFloat = 0.4

    private var isExpanding: Bool = false
    private var animationDelay: Double = 0

    public init(
        color: UIColor,
        delay: Double,
        frame: CGRect
    ) {
        super.init(frame: frame)

        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
        backgroundColor = color
        animationDelay = delay

        startAnimation()
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func startAnimation() {
        var animator: UIViewPropertyAnimator = .init(duration: animationDuration, curve: .linear)
        if isExpanding {
            animator = .init(duration: animationDuration / 1.05, curve: .easeInOut)
            animator.addAnimations {
                self.transform = .init(scaleX: 1.0, y: 1.0)
            }
        } else {
            animator.addAnimations {
                self.transform = .init(scaleX: self.expandRate, y: self.expandRate)
            }
        }

        animator.addCompletion { _ in
            self.startAnimation()
        }

        animator.startAnimation(afterDelay: animationDelay)

        if isExpanding {
            isExpanding = false
            animationDelay = 0.9
        } else {
            isExpanding = true
            animationDelay = 0.1
        }
    }
}
