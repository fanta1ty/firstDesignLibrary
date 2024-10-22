//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public final class TopCornersCell: UITableViewCell {
    public static let id = "TopCornersCell"

    let curve = UIView()

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .uiBackdrop

        curve.backgroundColor = .surfaceL1
        curve.layer.cornerRadius = DesignSystem.cornerRadiusLarger
        curve.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        curve.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(curve)

        curve.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
            .isActive = true
        curve.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            .isActive = true
        curve.topAnchor.constraint(equalTo: contentView.topAnchor)
            .isActive = true
        curve.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            .isActive = true
        curve.heightAnchor.constraint(equalToConstant: DesignSystem.cornerRadiusLarger)
            .isActive = true
    }
}
