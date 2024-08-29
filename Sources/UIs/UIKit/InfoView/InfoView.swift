//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public final class InfoView: UIView {
    public let stackView = UIStackView()
    public let imageContainer = UIView()
    public let image = UIImageView()
    public let title = UILabel()
    public let message = UILabel()
    public let retryButton = DesignButton()
    public var onSelectRetry: (() -> Void)?

    public var width: NSLayoutConstraint?
    public var height: NSLayoutConstraint?

    public var imageSize = CGSize(width: 160, height: 160) {
        didSet {
            width?.constant = imageSize.width
            height?.constant = imageSize.height
        }
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = false
        imageContainer.addSubview(image)

        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: imageContainer.topAnchor, constant: 8),
            image.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor),
            image.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor),
        ])
        height = image.heightAnchor.constraint(equalToConstant: 160)
        height?.isActive = true

        width = image.widthAnchor.constraint(equalToConstant: 164)
        width?.isActive = true

        title.font = .heading4
        title.textColor = .textPrimary
        title.textAlignment = .center
        title.numberOfLines = 0

        message.font = .body2
        message.textColor = .textSecondary
        message.textAlignment = .center
        message.numberOfLines = 0

        retryButton.isSecondary = true
        retryButton.isCompact = true
        retryButton.isHidden = true
        retryButton.addTarget(self, action: #selector(didSelectRetry), for: .touchUpInside)

        stackView.set(arrangedSubviews: [imageContainer, title, message, retryButton])
        stackView.setCustomSpacing(32, after: imageContainer)
        stackView.setCustomSpacing(8, after: title)
        stackView.setCustomSpacing(24, after: message)

        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
        ])
    }

    public func set(
        image: UIImage?,
        title: String?,
        message: String?,
        cta: String? = nil
    ) {
        self.image.image = image
        imageContainer.isHidden = image == nil

        self.title.text = title
        self.title.isHidden = title == nil

        self.message.text = message
        self.message.isHidden = message == nil

        retryButton.isHidden = cta == nil
        retryButton.titleText = cta
    }

    @objc func didSelectRetry(_: Any) {
        onSelectRetry?()
    }
}
