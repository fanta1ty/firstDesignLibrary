//  Created by Thinh Nguyen
//

import UIKit

public final class NextBestActionView: UIView {
    public let heading = UILabel()
    public let text = UILabel()
    public let icon = UIImageView()
    public let close = UIButton(type: .system)

    public var onSelectClose: (() -> Void)?

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .init(width: 0, height: 10)
        layer.shadowRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.borderSubtle.cgColor
        layer.cornerRadius = DesignSystem.cornerRadiusSmall
        heightAnchor.constraint(greaterThanOrEqualToConstant: 64).isActive = true

        icon.image = .placeholder.withRenderingMode(.alwaysTemplate)
        icon.contentMode = .center
        icon.backgroundColor = .uiAccent
        icon.tintColor = .iconInverse
        icon.layer.cornerRadius = 4
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.setContentHuggingPriority(.required, for: .horizontal)
        icon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 40).isActive = true

        let textContainer = UIView()

        heading.font = .body2Strong
        heading.textColor = .textPrimary
        heading.numberOfLines = 0
        heading.translatesAutoresizingMaskIntoConstraints = false
        textContainer.addSubview(heading)
        heading.topAnchor.constraint(equalTo: textContainer.topAnchor, constant: 12).isActive = true
        heading.leadingAnchor.constraint(equalTo: textContainer.leadingAnchor).isActive = true
        heading.trailingAnchor.constraint(equalTo: textContainer.trailingAnchor).isActive = true

        text.font = .body2
        text.textColor = .textSecondary
        text.numberOfLines = 0
        text.translatesAutoresizingMaskIntoConstraints = false
        textContainer.addSubview(text)
        text.topAnchor.constraint(equalTo: heading.bottomAnchor, constant: 2).isActive = true
        text.bottomAnchor.constraint(equalTo: textContainer.bottomAnchor, constant: -12).isActive = true
        text.leadingAnchor.constraint(equalTo: textContainer.leadingAnchor).isActive = true
        text.trailingAnchor.constraint(equalTo: textContainer.trailingAnchor).isActive = true

        let stack = UIStackView(arrangedSubviews: [icon, textContainer])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        stack.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true

        close.setImage(.closeCircle.withRenderingMode(.alwaysTemplate), for: .normal)
        close.tintColor = .iconDisabled
        close.isHidden = true
        close.addTarget(self, action: #selector(didSelectClose), for: .touchUpInside)
        close.setContentHuggingPriority(.required, for: .horizontal)
        close.translatesAutoresizingMaskIntoConstraints = false
        addSubview(close)
        close.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        close.leadingAnchor.constraint(equalTo: stack.trailingAnchor).isActive = true
        close.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        close.heightAnchor.constraint(equalToConstant: 40).isActive = true
        close.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }

    @objc func didSelectClose(sender _: UIButton) {
        onSelectClose?()
    }

    public func configure(heading: String, text: String, isCloseHidden: Bool) {
        self.heading.text = heading
        self.text.text = text
        close.isHidden = isCloseHidden
    }

    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        let previous: UIUserInterfaceStyle = previousTraitCollection?.userInterfaceStyle ?? .unspecified
        if previous != traitCollection.userInterfaceStyle {
            layer.borderColor = UIColor.borderSubtle.cgColor
        }
    }
}
