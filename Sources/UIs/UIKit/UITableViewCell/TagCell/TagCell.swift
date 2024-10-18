//  Created by Thinh Nguyen
//

import UIKit

public final class TagCell: UITableViewCell {
    public static let id = "TagCell"

    public let tagView = TagView()
    public var top: NSLayoutConstraint?
    public var bottom: NSLayoutConstraint?

    override public init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .uiBackgroundSecondary

        tagView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tagView)
        tagView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24).isActive = true
        tagView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -24).isActive = true
        top = tagView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24)
        top?.isActive = true
        bottom = tagView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        bottom?.isActive = true
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func prepareForReuse() {
        super.prepareForReuse()
        top?.constant = 24
        bottom?.constant = -24
    }
}
