//  Created by Thinh Nguyen
//

import UIKit

public final class TagCell: UITableViewCell {
    public static let id = "TagCell"

    public let tagView = TagView()
    public var top:
    public var height: NSLayoutConstraint?

    override public init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .uiBackgroundSecondary

        height = contentView.heightAnchor.constraint(equalToConstant: 16)
        height?.isActive = true
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func prepareForReuse() {
        super.prepareForReuse()
        height?.constant = 16
    }
}
