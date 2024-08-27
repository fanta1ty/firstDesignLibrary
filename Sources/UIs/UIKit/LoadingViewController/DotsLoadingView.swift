//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public final class DotsLoadingView: UIView {
    public let loadingViewBackgroundColor: UIColor = .white

    private let delay: TimeInterval = 0.25
    private let dotSize: CGFloat = 15
    private let defaultColors: [UIColor] = [
        UIColor(hexString: "#4284F7")!,
        UIColor(hexString: "#F74239")!,
        UIColor(hexString: "#FDBC02")!,
        UIColor(hexString: "#4AB552")!,
    ]

    private var dots: [DotView] = []
    public var colors: [UIColor]

    public init(colors: [UIColor]? = nil) {
        self.colors = colors?.count == 4 ? colors! : defaultColors
        super.init(frame: .init(x: 0, y: 0, width: 100, height: 100))
        backgroundColor = .clear
        setupView()
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
            return
        }
        rootViewController.view.addSubview(self)
        center = rootViewController.view.center
        createDots()
    }

    private func createDots() {
        dots.forEach { $0.removeFromSuperview() }
        dots.removeAll()

        let spacing = dotSize * 0.8
        let startX = CGFloat(2)

        for (index, color) in colors.enumerated() {
            let dot = DotView(color: color, delay: delay * Double(index), frame: CGRect(x: 0, y: 0, width: dotSize, height: dotSize))
            let xOffset = startX + CGFloat(index) * (dotSize + spacing)
            dot.center = CGPoint(x: xOffset + dotSize / 2, y: frame.height / 2)

            dots.append(dot)
            addSubview(dot)
        }
    }
}
