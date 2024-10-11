//  Created by Thinh Nguyen
//

import Combine
import Foundation
import UIKit

public final class ButtonCell: UITableViewCell {
    public static let id = "ButtonCell"

    public let button = DesignButton(frame: .zero)

    public var cancellables: [AnyCancellable] = []
    public var didSelect: (() -> Void)?

    override public init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .uiBackgroundPrimary

        button.addTarget(self, action: #selector(didSelect(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(button)

        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func prepareForReuse() {
        super.prepareForReuse()
    }

    @objc private func didSelect(sender _: UIControl) {
        didSelect?()
    }
}
