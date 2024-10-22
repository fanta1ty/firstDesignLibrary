//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public final class ToastView: UIView {
    public let icon = UIImageView()
    public let stack = UIStackView()
    public let close = UIButton(type: .system)
    public let newStack = UIStackView()

    public var layerBorder: UIColor?

    public weak var delegate: ToastViewDelegate?

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = DesignSystem.cornerRadiusSmall

        newStack.axis = .horizontal
        newStack.alignment = .leading
        newStack.translatesAutoresizingMaskIntoConstraints = false
        newStack.spacing = 8
        addSubview(newStack)

        NSLayoutConstraint.activate([
            newStack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            newStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            newStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            newStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])

        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.setContentCompressionResistancePriority(.required, for: .horizontal)
        icon.setContentHuggingPriority(.required, for: .horizontal)

        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false

        close.setImage(.close.withRenderingMode(.alwaysTemplate), for: .normal)
        close.tintColor = .icon
        close.addTarget(self, action: #selector(didSelectClose), for: .touchUpInside)
        close.translatesAutoresizingMaskIntoConstraints = false
        close.setContentCompressionResistancePriority(.required, for: .horizontal)
        close.setContentHuggingPriority(.required, for: .horizontal)

        newStack.set(arrangedSubviews: [icon, stack, close])
    }

    override public func updateConstraints() {
        super.updateConstraints()
    }

    @objc public func didSelectClose(sender: UIButton) {
        delegate?.toast(view: self, didSelectClose: sender)
    }

    @objc public func didSelectLink(sender: UIButton) {
        delegate?.toast(view: self, didSelectLink: sender)
    }

    public func configure(
        status: DesignSystem.Status,
        heading: String?,
        text: String?,
        link: String?,
        isCloseHidden: Bool,
        isOutline: Bool,
        isIconHidden: Bool = false,
        isReverseColor: Bool = false
    ) {
        var views: [UIView] = []
        if let heading {
            let l = UILabel()
            l.text = heading
            l.textColor = .textPrimary
            l.font = .heading5
            l.numberOfLines = 0
            views.append(l)
        }

        if let text {
            let l = UILabel()
            l.text = text
            l.textColor = isReverseColor ? .textPrimaryLight : .textPrimary
            l.font = .body2
            l.numberOfLines = 0
            views.append(l)
        }

        if let link {
            let b = UIButton(type: .system)
            b.setTitle(link, for: .normal)
            b.setTitleColor(.textLink, for: .normal)
            b.titleLabel?.font = .link1
            b.titleLabel?.numberOfLines = 0
            b.addTarget(self, action: #selector(didSelectLink), for: .touchUpInside)
            views.append(b)
        }

        stack.set(arrangedSubviews: views)
        icon.isHidden = isIconHidden
        icon.image = status.icon.withRenderingMode(.alwaysTemplate)
        icon.tintColor = isReverseColor ? .iconLight : status.color
        close.isHidden = isCloseHidden

        backgroundColor = isOutline ? nil : (isReverseColor ? status.reverseBackgroundColor : status.backgroundColor)
        layer.shadowColor = isOutline ? nil : UIColor.black.cgColor
        layer.shadowOffset = .init(width: 0, height: 10)
        layer.shadowRadius = 10
        layer.shadowOpacity = isOutline ? 0 : 0.2
        layer.borderWidth = isOutline ? 1 : 0

        layerBorder = isOutline ? .borderSubtle : nil
        layer.borderColor = layerBorder?.cgColor

        setNeedsUpdateConstraints()
    }

    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        let previous: UIUserInterfaceStyle = previousTraitCollection?.userInterfaceStyle ?? .unspecified
        if previous != traitCollection.userInterfaceStyle {
            layer.borderColor = layerBorder?.cgColor
        }
    }
}
