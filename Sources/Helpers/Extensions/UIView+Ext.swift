//  Created by Thinh Nguyen
//

import Foundation
import UIKit

extension UIView {
    static let lineDashPattern: [NSNumber] = [7, 3]
    static let lineDashWidth: CGFloat = 1.0
}

public extension UIView {
    func anchorToFillSuperview(
        insets: UIEdgeInsets = .zero,
        isTopSafe: Bool = false,
        isBottomSafe: Bool = false
    ) {
        guard let superview else { return }

        translatesAutoresizingMaskIntoConstraints = false

        topAnchor.constraint(
            equalTo: isTopSafe ? superview.safeAreaLayoutGuide.topAnchor : superview.topAnchor,
            constant: insets.top
        ).isActive = true

        bottomAnchor.constraint(
            equalTo: isBottomSafe ? superview.safeAreaLayoutGuide.bottomAnchor : superview.bottomAnchor,
            constant: -insets.bottom
        ).isActive = true

        leadingAnchor.constraint(
            equalTo: superview.leadingAnchor,
            constant: insets.left
        ).isActive = true

        trailingAnchor.constraint(
            equalTo: superview.trailingAnchor,
            constant: -insets.right
        ).isActive = true
    }

    func makeDashedBorderLine() {
        layer.sublayers?.forEach { $0.removeFromSuperlayer() }

        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = UIView.lineDashWidth
        shapeLayer.strokeColor = UIColor.border.cgColor
        shapeLayer.lineDashPattern = UIView.lineDashPattern

        let path = CGMutablePath()
        path.addLines(between: [
            .init(x: bounds.minX, y: bounds.height / 2),
            .init(x: bounds.width, y: bounds.height / 2),
        ])
        shapeLayer.path = path

        layer.addSublayer(shapeLayer)
    }

    func makeTriangle(color: UIColor) {
        layer.sublayers?.forEach { $0.removeFromSuperlayer() }

        let path = UIBezierPath()
        path.move(to: .init(x: 8, y: 0))
        path.move(to: .init(x: 0, y: 12))
        path.move(to: .init(x: 16, y: 12))
        path.close()

        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.fillColor = color.cgColor
        layer.addSublayer(shape)
    }
}
