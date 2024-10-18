//  Created by Thinh Nguyen
//

import UIKit

public final class ToastCell: UITableViewCell {
    public static let id = "ToastCell"

    public let toast = ToastView()
    public let divider = UIView()

    override public init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .uiBackgroundSecondary

        toast.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(toast)
        NSLayoutConstraint.activate([
            toast.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            toast.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            toast.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 28),
            toast.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -28),
        ])

        divider.isHidden = true
        divider.backgroundColor = .divider1
        contentView.addSubview(divider)
        NSLayoutConstraint.activate([
            divider.heightAnchor.constraint(equalToConstant: 1),
            divider.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            divider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            divider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
        ])
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func prepareForReuse() {
        super.prepareForReuse()
        divider.isHidden = true
    }
}
