//  Created by Thinh Nguyen
//

import Foundation
import UIKit

private enum K {
    static let scale = UIFont.label2.lineHeight / UIFont.body2.lineHeight
    static let labelUp = CGAffineTransform(scaleX: scale, y: scale)
}

public protocol MultilineDropDownViewDelegate: AnyObject {
    func multilineDropdown(viewDidSelect: MultilineDropDownView)
}

public class MultilineDropDownView: UIView {
    private let container = HighlightControl()
    private let label = UILabel()
    private let value = UILabel()
    private let icon = UIImageView(image: .inputFieldEdit.withRenderingMode(.alwaysTemplate))
    private let divider = UIView()

    private var labelTop: NSLayoutConstraint?
    private var labelCenter: NSLayoutConstraint?

    weak var delegate: MultilineDropDownViewDelegate?

    @IBInspectable public var isEnabled: Bool {
        get { container.isEnabled }
        set {
            container.isEnabled = newValue
            updateStyles()
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

    public func setup() {
        container.highlightColor = .uiHighlighted
        container.addTarget(self, action: #selector(didSelect), for: .touchUpInside)
        container.translatesAutoresizingMaskIntoConstraints = false
        addSubview(container)

        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.topAnchor.constraint(equalTo: topAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            container.heightAnchor.constraint(greaterThanOrEqualToConstant: 72),
        ])

        let inputContainer = UIView()
        inputContainer.isUserInteractionEnabled = false

        label.font = .body2
        label.textColor = .textTertiary
        label.layer.anchorPoint = .init(x: 0, y: 0.5)
        label.translatesAutoresizingMaskIntoConstraints = false
        inputContainer.addSubview(label)

        labelTop = label.topAnchor.constraint(equalTo: inputContainer.topAnchor)
        labelCenter = label.centerYAnchor.constraint(equalTo: inputContainer.centerYAnchor)
        labelCenter?.isActive = true
        label.widthAnchor.constraint(equalTo: inputContainer.widthAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: inputContainer.leadingAnchor).isActive = true

        value.font = .body2
        value.textColor = .textPrimary
        value.numberOfLines = 0
        value.translatesAutoresizingMaskIntoConstraints = false
        inputContainer.addSubview(value)

        NSLayoutConstraint.activate([
            value.leadingAnchor.constraint(equalTo: inputContainer.leadingAnchor),
            value.trailingAnchor.constraint(equalTo: inputContainer.trailingAnchor),
            value.topAnchor.constraint(equalTo: inputContainer.topAnchor, constant: 20),
            value.bottomAnchor.constraint(equalTo: inputContainer.bottomAnchor),
        ])

        icon.clipsToBounds = true
        icon.contentMode = .center
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.setContentHuggingPriority(.required, for: .horizontal)

        let stack = UIStackView(arrangedSubviews: [
            inputContainer,
            icon,
        ])
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.spacing = 8
        stack.isUserInteractionEnabled = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            stack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16),
            stack.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: container.trailingAnchor),
        ])

        divider.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(divider)

        NSLayoutConstraint.activate([
            divider.heightAnchor.constraint(equalToConstant: 1),
            divider.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            divider.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: container.trailingAnchor),
        ])

        updateStyles()
    }

    @objc public func didSelect() {
        delegate?.multilineDropdown(viewDidSelect: self)
    }

    public func updateStyles() {
        label.textColor = isEnabled ? .textTertiary : .textDisabled
        value.textColor = isEnabled ? .textPrimary : .textDisabled
        icon.tintColor = isEnabled ? .icon : .iconDisabled
        divider.backgroundColor = isEnabled ? .border : nil
    }

    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        let previous: UIUserInterfaceStyle = previousTraitCollection?.userInterfaceStyle ?? .unspecified
        if previous != traitCollection.userInterfaceStyle {
            container.layer.borderColor = UIColor.border.cgColor
        }
    }

    override public var intrinsicContentSize: CGSize {
        .init(width: 160, height: 72)
    }

    override public func updateConstraints() {
        super.updateConstraints()

        let isUp = !(value.text ?? "").isEmpty
        updateLabel(isUp: isUp, animated: false)
    }

    private func updateLabel(isUp: Bool, animated: Bool) {
        labelTop?.isActive = isUp
        labelCenter?.isActive = !isUp
        if animated {
            UIView.animate(withDuration: 0.3, animations: {
                self.layoutIfNeeded()
                self.label.transform = isUp ? K.labelUp : .identity
            })
        } else {
            label.transform = isUp ? K.labelUp : .identity
        }
    }
}

public extension MultilineDropDownView {
    var labelText: String {
        get { label.text ?? "" }
        set { label.text = newValue }
    }

    var valueText: String? {
        get { value.text ?? "" }
        set { value.text = newValue }
    }

    func setValueText(_ newValue: String, animated: Bool) {
        valueText = newValue
        let wasUp = (value.text ?? "").isEmpty
        let isNowUp = !newValue.isEmpty
        value.text = newValue

        if animated, wasUp, !isNowUp {
            updateLabel(isUp: false, animated: animated)
        } else if animated, !wasUp, isNowUp {
            updateLabel(isUp: true, animated: animated)
        } else {
            setNeedsUpdateConstraints()
        }
    }

    var iconImage: UIImage? {
        get { icon.image }
        set {
            icon.image = newValue?.withRenderingMode(.alwaysTemplate)
            icon.isHidden = newValue == nil
        }
    }

    var isIconHidden: Bool {
        get { icon.isHidden }
        set { icon.isHidden = newValue }
    }
}
