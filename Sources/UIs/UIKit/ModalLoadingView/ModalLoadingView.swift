//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public final class ModalLoadingView: UIView {
    public static let animationSize: CGFloat = 100

    public let blur = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
    private let loadingContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .uiBackgroundPrimary.withAlphaComponent(0.3)
        view.layer.cornerRadius = 20
        return view
    }()

    private let loading = DotsLoadingView(colors: nil)
    private let presentingStartTime = CACurrentMediaTime()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        blur.translatesAutoresizingMaskIntoConstraints = false
        addSubview(blur)
        NSLayoutConstraint.activate([
            blur.leadingAnchor.constraint(equalTo: leadingAnchor),
            blur.trailingAnchor.constraint(equalTo: trailingAnchor),
            blur.topAnchor.constraint(equalTo: topAnchor),
            blur.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        addSubview(loadingContainer)
        NSLayoutConstraint.activate([
            loadingContainer.widthAnchor.constraint(equalToConstant: Self.animationSize),
            loadingContainer.heightAnchor.constraint(equalToConstant: Self.animationSize),
            loadingContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])

        loading.contentMode = .scaleAspectFit
        loading.translatesAutoresizingMaskIntoConstraints = false
        loadingContainer.addSubview(loading)
        loading.anchorToFillSuperview()

        NSLayoutConstraint.activate([
            loading.widthAnchor.constraint(equalToConstant: Self.animationSize),
            loading.heightAnchor.constraint(equalToConstant: Self.animationSize),
            loading.centerXAnchor.constraint(equalTo: centerXAnchor),
            loading.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    public func dismiss(completion: @escaping () -> Void) {
        let duration = CACurrentMediaTime() - presentingStartTime
        let dismissDuration = min(duration, 0.3)

        UIView.animateKeyframes(
            withDuration: dismissDuration,
            delay: 0,
            options: .beginFromCurrentState,
            animations: { self.alpha = 0 },
            completion: { _ in
                self.cleanup()
                completion()
            }
        )
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

    private func cleanup() {
        subviews.forEach { $0.removeFromSuperview() }
        removeFromSuperview()
    }
}
