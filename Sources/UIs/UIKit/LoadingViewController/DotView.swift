//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public final class DotView: UIView {
    private let expandRate: CGFloat = 2.0
    private let animationDuration: TimeInterval = 0.4

    private var isExpanding: Bool = false
    private var animationDelay: TimeInterval

    public init(
        color: UIColor,
        delay: TimeInterval,
        frame: CGRect
    ) {
        animationDelay = delay
        super.init(frame: frame)

        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
        backgroundColor = color

        startAnimation()
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func startAnimation() {
        let scale: CGFloat = isExpanding ? 1.0 : expandRate
        let adjustedDuration = isExpanding ? animationDuration / 1.05 : animationDuration

        let animator = UIViewPropertyAnimator(duration: adjustedDuration, curve: .easeInOut) {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        }

        animator.addCompletion { _ in
            self.isExpanding.toggle()
            self.animationDelay = self.isExpanding ? 0.1 : 0.9
            self.startAnimation()
        }

        animator.startAnimation(afterDelay: animationDelay)
    }
}
