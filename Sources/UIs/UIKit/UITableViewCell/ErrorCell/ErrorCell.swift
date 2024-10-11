//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public final class ErrorCell: UITableViewCell {
    public static let id = "ErrorCell"

    public let label = UILabel()

    public var top: NSLayoutConstraint?
    public var bottom: NSLayoutConstraint?

    override public init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .clear

        label.text = "Sorry, something went wrong. Please try again later.".localised
        label.numberOfLines = 0
        label.textColor = .textBodySubtle
        label.font = .body1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
        ])

        top = label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24)
        top?.isActive = true

        bottom = label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        bottom?.isActive = true
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func prepareForReuse() {
        super.prepareForReuse()

        top?.constant = 24
        bottom?.constant = -24
    }
}
