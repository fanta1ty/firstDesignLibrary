//  Created by Thinh Nguyen
//

import Combine
import Foundation
import UIKit

public final class HeadingWithChevronCell: UITableViewCell {
    public static let id = "HeadingWithChevronCell"

    public let title = UILabel()
    public let chevron = UIButton(type: .system)
    public let divider = UIView()

    public var top: NSLayoutConstraint?
    public var bottom: NSLayoutConstraint?

    public var cancellables: [AnyCancellable] = []
    public var onSelectChevron: (() -> Void)? {
        didSet {
            chevron.isUserInteractionEnabled = onSelectChevron != nil
        }
    }

    override public init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .uiBackgroundPrimary

        chevron.setTitleColor(.textLink, for: .normal)
        chevron.setImage(.navigationRight, for: .normal)
        chevron.titleLabel?.font = .link1
        chevron.tintColor = .iconActive
        chevron.isUserInteractionEnabled = false
        chevron.addTarget(self, action: #selector(didSelectChevron), for: .touchUpInside)
        chevron.translatesAutoresizingMaskIntoConstraints = false
        chevron.setContentCompressionResistancePriority(.required, for: .horizontal)
        contentView.addSubview(chevron)
        chevron.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
            .isActive = true

        title.numberOfLines = 0
        title.textColor = .textPrimary
        title.font = .heading4Strong
        title.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(title)

        top = title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24)
        top?.isActive = true

        bottom = title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        bottom?.isActive = true

        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            title.trailingAnchor.constraint(lessThanOrEqualTo: chevron.leadingAnchor, constant: -8),
            chevron.centerYAnchor.constraint(equalTo: title.centerYAnchor),
        ])

        divider.isHidden = true
        divider.backgroundColor = .divider1
        divider.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(divider)

        NSLayoutConstraint.activate([
            divider.heightAnchor.constraint(equalToConstant: 1),
            divider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            divider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            divider.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func prepareForReuse() {
        super.prepareForReuse()
        onSelectChevron = nil
        cancellables.removeAll()

        divider.isHidden = true
        chevron.setTitle(nil, for: .normal)

        top?.constant = 24
        bottom?.constant = -24
    }

    @objc func didSelectChevron(sender _: UIControl) {
        onSelectChevron?()
    }
}
