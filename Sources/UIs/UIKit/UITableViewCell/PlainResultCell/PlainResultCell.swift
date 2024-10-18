//  Created by Thinh Nguyen
//

import UIKit

public final class PlainResultCell: UITableViewCell {
    public static let id = "PlainResultCell"

    public let label = UILabel()
    public let line = UIView()

    override public init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .uiBackgroundPrimary

        label.numberOfLines = 0
        label.textColor = .textBody
        label.font = .body1
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        ])

        line.backgroundColor = .divider1
        line.isUserInteractionEnabled = false
        line.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(line)

        NSLayoutConstraint.activate([
            line.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            line.topAnchor.constraint(equalTo: contentView.bottomAnchor),
            line.heightAnchor.constraint(equalToConstant: 1),
        ])
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
