//  Created by Thinh Nguyen
//

import Combine
import Foundation
import UIKit

public final class LoadingCell: UITableViewCell {
    public static let id = "LoadingCell"

    public let indicator = UIActivityIndicatorView(style: .medium)
    public var top: NSLayoutConstraint?
    public var bottom: NSLayoutConstraint?

    override public init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .clear

        indicator.color = .textBody
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(indicator)

        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])

        top = indicator.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32)
        top?.isActive = true

        bottom = indicator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32)
        bottom?.isActive = true
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func prepareForReuse() {
        super.prepareForReuse()

        indicator.startAnimating()
        top?.constant = 32
        bottom?.constant = -32
    }
}
