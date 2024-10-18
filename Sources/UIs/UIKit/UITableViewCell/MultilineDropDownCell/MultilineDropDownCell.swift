//  Created by Thinh Nguyen
//

import Combine
import Foundation
import UIKit

public final class MultilineDropDownCell: UITableViewCell {
    public static let id = "MultilineDropDownCell"
    public let multilineDropDown = MultilineDropDownView()

    private var cancellables: [AnyCancellable] = []
    public var didSelect: (() -> Void)?

    override public init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .uiBackgroundPrimary

        multilineDropDown.delegate = self
        multilineDropDown.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(multilineDropDown)

        NSLayoutConstraint.activate([
            multilineDropDown.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            multilineDropDown.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            multilineDropDown.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            multilineDropDown.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        ])
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func prepareForReuse() {
        super.prepareForReuse()

        cancellables.removeAll()
        didSelect = nil
    }
}

extension MultilineDropDownCell: MultilineDropDownViewDelegate {
    public func multilineDropdown(viewDidSelect _: MultilineDropDownView) {
        didSelect?()
    }
}
