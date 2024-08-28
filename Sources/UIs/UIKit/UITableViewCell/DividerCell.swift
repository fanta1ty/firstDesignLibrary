//  Created by Thinh Nguyen
//

import Combine
import Foundation
import UIKit

public final class DividerCell: UITableViewCell {
    public static let id = "DividerCell"

    public let line = UIView()
    public var leading: NSLayoutConstraint?
    public var trailing: NSLayoutConstraint?
    public var top: NSLayoutConstraint?
    public var bottom: NSLayoutConstraint?

    override public init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .uiBackgroundPrimary

        line.backgroundColor = .divider1
        line.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(line)

        line.heightAnchor.constraint(equalToConstant: 1)
            .isActive = true

        leading = line.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        leading?.isActive = true

        trailing = line.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        trailing?.isActive = true

        top = line.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24)
        top?.isActive = true

        bottom = line.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        bottom?.isActive = true
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func prepareForReuse() {
        super.prepareForReuse()

        leading?.constant = 0
        trailing?.constant = 0
        top?.constant = 24
        bottom?.constant = -16
    }
}
