//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public final class TagView: UIView {
    public let label = UILabel()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    var status: DesignSystem.Status = .general {
        didSet {
            updateStyle()
        }
    }

    var isInverse: Bool = false {
        didSet {
            updateStyle()
        }
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 16).isActive = true
        backgroundColor = status.backgroundColor

        label.font = .body3
        label.textColor = .textPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)

        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }

    private func updateStyle() {
        backgroundColor = isInverse ? status.color : status.backgroundColor
        label.textColor = isInverse ? .textPrimaryInverse : status.color
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }

    public override var intrinsicContentSize: CGSize {
        .init(
            width: ceil(label.intrinsicContentSize.width) + 16,
            height: 16
        )
    }
}
