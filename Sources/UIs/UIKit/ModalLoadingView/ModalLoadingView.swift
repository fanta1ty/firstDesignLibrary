//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public final class ModalLoadingView: UIView {
    public static let animationSize: CGFloat = 100

    public let blur = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
    public let animationContainer = UIView()
    private let loading = DotsLoadingView(colors: nil)
    private let presentingStartTime = CACurrentMediaTime()

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public init() {
        super.init(frame: .zero)

        blur.alpha = 0
        blur.translatesAutoresizingMaskIntoConstraints = false
        addSubview(blur)

        blur.leadingAnchor.constraint(equalTo: leadingAnchor)
            .isActive = true
        blur.trailingAnchor.constraint(equalTo: trailingAnchor)
            .isActive = true
        blur.topAnchor.constraint(equalTo: topAnchor)
            .isActive = true
        blur.bottomAnchor.constraint(equalTo: bottomAnchor)
            .isActive = true

        animationContainer.alpha = 0
        animationContainer.translatesAutoresizingMaskIntoConstraints = false
        addSubview(animationContainer)

        animationContainer.widthAnchor.constraint(equalToConstant: Self.animationSize)
            .isActive = true
        animationContainer.heightAnchor.constraint(equalToConstant: Self.animationSize)
            .isActive = true
        animationContainer.centerXAnchor.constraint(equalTo: centerXAnchor)
            .isActive = true
        animationContainer.centerYAnchor.constraint(equalTo: centerYAnchor)
            .isActive = true

        loading.contentMode = .scaleAspectFit
        loading.translatesAutoresizingMaskIntoConstraints = false
        animationContainer.addSubview(loading)
        loading.anchorToFillSuperview()

        DispatchQueue.main.async {
            self.loading.show()
        }
    }

    public func dismiss(completion: @escaping () -> Void) {
        let duration = CACurrentMediaTime() - presentingStartTime
        let dismissDuration = min(duration, 0.3)

        UIView.animateKeyframes(withDuration: dismissDuration, delay: 0, options: .beginFromCurrentState, animations: {
            self.alpha = 0
        }, completion: { _ in
            self.removeFromSuperview()
            completion()
        })
    }

    public func dismiss() async {
        await withCheckedContinuation { continuation in
            dismiss {
                continuation.resume()
            }
        }
    }

    public func dismiss() {
        dismiss(completion: {})
    }
}
