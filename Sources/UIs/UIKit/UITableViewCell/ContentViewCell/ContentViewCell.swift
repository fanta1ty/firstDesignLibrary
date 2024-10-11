//  Created by Thinh Nguyen
//

import Combine
import Foundation
import UIKit

public final class ContentViewCell: UITableViewCell {
    public static let id = "ContentViewCell"

    public var cancellables: [AnyCancellable] = []

    override public init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .uiBackgroundPrimary
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func prepareForReuse() {
        super.prepareForReuse()

        cancellables.removeAll()
        selectionStyle = .none
        backgroundColor = .uiBackgroundPrimary

        if #available(iOS 16.0, *) {}
        else {
            contentConfiguration = nil
        }
    }
}
