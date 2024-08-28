//  Created by Thinh Nguyen
//

import Combine
import Foundation
import UIKit

public final class HeadingCell: UITableViewCell {
    public static let id = "HeadingCell"

    public let label = UILabel()
    public let divider = UIView()

    public var top: NSLayoutConstraint?
    public var bottom: NSLayoutConstraint?

    public var cancellables: [AnyCancellable] = []

    override public init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .uiBackgroundPrimary

        label.numberOfLines = 0
        label.textColor = .textPrimary
        label.font = .body2
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)

        top = label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24)
        top?.isActive = true

        bottom = label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        bottom?.isActive = true

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
        ])

        divider.isHidden = true
        divider.backgroundColor = .divider1
        divider.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(divider)

        NSLayoutConstraint.activate([
            divider.heightAnchor.constraint(equalToConstant: 1),
            divider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
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

        divider.isHidden = true
        cancellables.removeAll()
    }
}
