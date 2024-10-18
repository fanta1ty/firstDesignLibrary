//  Created by Thinh Nguyen
//

import UIKit

public final class NextBestActionCell: UITableViewCell {
    public static let id = "NextBestActionCell"

    public let nba = NextBestActionView()
    public var top: NSLayoutConstraint?
    public var bottom: NSLayoutConstraint?

    override public init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .uiBackgroundPrimary

        nba.backgroundColor = .uiBackgroundPrimary
        nba.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nba)
        top = nba.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8)
        top?.isActive = true
        bottom = nba.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        bottom?.isActive = true

        nba.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24).isActive = true
        nba.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24).isActive = true
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func prepareForReuse() {
        super.prepareForReuse()

        nba.onSelectClose = nil
        top?.constant = 8
        bottom?.constant = -8
    }
}
