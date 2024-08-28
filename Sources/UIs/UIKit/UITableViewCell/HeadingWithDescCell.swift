//  Created by Thinh Nguyen
//

import Combine
import Foundation
import UIKit

public final class HeadingWithDescCell: UITableViewCell {
    public static let id = "HeadingWithDescCell"

    public let label = UILabel()
    public let subLabel = UILabel()
    public let icon = UIImageView()
    public let contentStack = UIStackView()
    public let divider = UIView()

    public var top: NSLayoutConstraint?
    public var bottom: NSLayoutConstraint?

    override public init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .uiBackgroundPrimary

        icon.tintColor = .iconActive
        icon.isHidden = true
        icon.setContentHuggingPriority(.required, for: .horizontal)

        label.numberOfLines = 0
        label.textColor = .textTertiary
        label.font = .body3

        subLabel.numberOfLines = 0
        subLabel.font = .body2
        subLabel.textColor = .textPrimary

        contentStack.addArrangedSubview(label)
        contentStack.addArrangedSubview(subLabel)
        contentStack.axis = .vertical

        let container = UIStackView(arrangedSubviews: [icon, contentStack])
        container.axis = .horizontal
        container.spacing = 16
        container.alignment = .center
        container.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(container)

        top = container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24)
        top?.isActive = true

        bottom = container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        bottom?.isActive = true

        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
        ])

        divider.backgroundColor = .divider1
        divider.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(divider)

        NSLayoutConstraint.activate([
            divider.heightAnchor.constraint(equalToConstant: 1),
            divider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            divider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            divider.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func prepareForReuse() {
        super.prepareForReuse()

        label.font = .body2

        top?.constant = 24
        bottom?.constant = -24

        contentStack.spacing = 0
        divider.isHidden = false
        icon.isHidden = true
    }
}
