//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public final class DotsLoadingView: UIView {
    public let loadingViewBackgroundColor: UIColor = .white

    private let delay = 0.25
    private let length = 15

    private let dotBlue = UIColor(hexString: "#4284F7")!
    private let dotRed = UIColor(hexString: "#F74239")!
    private let dotYellow = UIColor(hexString: "#FDBC02")!
    private let dotGreen = UIColor(hexString: "#4AB552")!

    public var colors: [UIColor] = []
    private var dots: [DotView] = []

    public init(colors: [UIColor]?) {
        super.init(frame: .init(x: 0, y: 0, width: 150, height: 100))
        backgroundColor = .clear

        if let colors = colors {
            if colors.count == 4 {
                self.colors = colors
            } else {
                self.colors = [dotBlue, dotRed, dotYellow, dotGreen]
            }
        } else {
            self.colors = [dotBlue, dotRed, dotYellow, dotGreen]
        }
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func show() {
        guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
            return
        }

        if let window = rootViewController.view.window {
            frame = window.bounds
            window.addSubview(self)
            center = window.center
        } else {
            rootViewController.view.addSubview(self)
            frame = rootViewController.view.bounds
            center = rootViewController.view.center
        }

        startAnimation()
    }

    public func stop() {
        let animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) {
            for dot in self.dots {
                dot.alpha = 0
            }
        }
        animator.startAnimation()
        animator.addCompletion { _ in
            self.removeFromSuperview()
        }
    }

    private func startAnimation() {
        dots.forEach { $0.removeFromSuperview() }
        dots.removeAll()

        let dotWidth = CGFloat(length)
        let spacing = dotWidth * 0.8 // Adjust this factor to control the space between dots
        let totalWidth = CGFloat(colors.count) * dotWidth + CGFloat(colors.count - 1) * spacing

        for i in 0 ..< colors.count {
            let dotFrame = CGRect(x: 0, y: 0, width: dotWidth, height: dotWidth)
            let dot = DotView(color: colors[i], delay: delay * Double(i), frame: dotFrame)

            let xOffset = (frame.width - totalWidth) / 2 + CGFloat(i) * (dotWidth + spacing)
            dot.center = CGPoint(
                x: xOffset,
                y: frame.height / 2
            )
            dots.append(dot)
            addSubview(dot)
        }
    }
}
