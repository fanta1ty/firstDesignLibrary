//  Created by Thinh Nguyen
//

import Combine
import Foundation
import UIKit

public final class InfoCell: UITableViewCell {
    public static let id = "InfoCell"

    public let info = InfoView()

    override public init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .clear

        info.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(info)

        NSLayoutConstraint.activate([
            info.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            info.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            info.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 78),
            info.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
