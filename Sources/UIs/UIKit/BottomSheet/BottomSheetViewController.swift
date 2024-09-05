//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public class BottomSheetViewController: UIViewController {
    let container = UIView()
    let overlay = UIView()
    let drag = UIView()

    var customHeight: CGFloat = 300
    var showCloseButton: Bool = false
    var child: UIViewController?

    var bottom: NSLayoutConstraint?
    var height: NSLayoutConstraint?

    private var topPresentingVC: UIViewController?

    var customHeightWithSafeArea: CGFloat {
        guard let window = view.window ?? UIApplication.shared.sceneKeyWindow else { return customHeight }
        return customHeight + window.safeAreaInsets.bottom
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear

        overlay.backgroundColor = .black
        overlay.alpha = 0
        overlay.isUserInteractionEnabled = true
        overlay.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didDismiss)))
        overlay.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(overlay)
        overlay.anchorToFillSuperview()

        container.alpha = 0
        container.backgroundColor = .uiBackgroundPrimary
        container.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(container)

        bottom = container.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        bottom?.isActive = true
        container.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        container.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor, multiplier: 0.8).isActive = true

        height = container.heightAnchor.constraint(equalToConstant: customHeightWithSafeArea)
        height?.priority = .defaultLow
        height?.isActive = true

        drag.alpha = 0
        drag.backgroundColor = .uiBackgroundPrimary
        drag.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(drag)
        drag.heightAnchor.constraint(equalToConstant: 20).isActive = true
        drag.bottomAnchor.constraint(equalTo: container.topAnchor).isActive = true
        drag.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        drag.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        let bar = UIView()
        bar.backgroundColor = .borderDisabled
        bar.layer.cornerRadius = 2
        bar.translatesAutoresizingMaskIntoConstraints = false
        drag.addSubview(bar)
        bar.widthAnchor.constraint(equalToConstant: 50).isActive = true
        bar.topAnchor.constraint(equalTo: drag.topAnchor, constant: 8).isActive = true
        bar.bottomAnchor.constraint(equalTo: drag.bottomAnchor, constant: -8).isActive = true
        bar.centerXAnchor.constraint(equalTo: drag.centerXAnchor).isActive = true
        bar.isHidden = showCloseButton

        let pan = UIPanGestureRecognizer(target: self, action: #selector(didPan))
        pan.delaysTouchesBegan = false
        pan.delaysTouchesEnded = false
        view.addGestureRecognizer(pan)

        if let bottomSheetChild = child as? BottomSheetChild {
            bottomSheetChild.delegate = self
        }

        if let child {
            addChild(child)
            container.addSubview(child.view)
            child.view.anchorToFillSuperview()
            child.didMove(toParent: self)
        }

        if showCloseButton {
            let close = UIButton(type: .system)
            close.tintColor = .iconActive
            close.setImage(.close, for: .normal)
            close.addTarget(self, action: #selector(didDismiss), for: .touchUpInside)
            close.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview(close)

            close.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -24).isActive = true
            close.topAnchor.constraint(equalTo: container.topAnchor, constant: 4).isActive = true
            close.widthAnchor.constraint(equalToConstant: 24).isActive = true
            close.heightAnchor.constraint(equalToConstant: 24).isActive = true
        }
    }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let offset = container.frame.height + drag.frame.height
        let transform = CGAffineTransform(translationX: 0, y: offset)
        container.transform = transform
        container.alpha = 1
        drag.transform = transform
        drag.alpha = 1

        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.container.transform = .identity
            self.drag.transform = .identity
            self.overlay.alpha = 0.3
        }, completion: nil)
    }

    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard isBeingDismissed else { return }

        topPresentingVC = (presentingViewController as? UINavigationController)?.topViewController ?? presentingViewController
    }

    @objc func didDismiss() {
        dismissWithCustomAnimation()
    }

    @objc func didPan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)

        switch gesture.state {
        case .changed:
            let newBottom = max(0, translation.y)
            bottom?.constant = newBottom

        case .ended:
            let translationWithVelocity = translation.y + velocity.y
            let velocityProgress = translationWithVelocity / container.bounds.height
            let shouldComplete = velocityProgress > 0.5

            if shouldComplete {
                dismissWithCustomAnimation()
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.bottom?.constant = 0
                    self.view.layoutIfNeeded()
                })
            }

        default: break
        }
    }

    func dismissWithCustomAnimation(completion: (() -> Void)? = nil) {
        view.isUserInteractionEnabled = false

        let offset = container.frame.height + drag.frame.height
        let transform = CGAffineTransform(translationX: 0, y: offset)

        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            self.container.transform = transform
            self.drag.transform = transform
            self.overlay.alpha = 0
        }, completion: { _ in
            self.dismiss(animated: false)
            completion?()
        })
    }
}

extension BottomSheetViewController: BottomSheetChildDelegate {
    public func didUpdate(child _: any BottomSheetChild, height: CGFloat) {
        customHeight = height
        self.height?.constant = customHeightWithSafeArea
    }
}

public extension BottomSheetViewController {
    static func instantiate(
        child: UIViewController,
        customHeight: CGFloat = 300,
        showCloseButton: Bool = false
    ) -> BottomSheetViewController {
        let vc = BottomSheetViewController()
        vc.child = child
        vc.customHeight = customHeight
        vc.showCloseButton = showCloseButton
        vc.modalPresentationStyle = .overFullScreen
        return vc
    }
}
