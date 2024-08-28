//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public final class DesignButton: UIButton {
    public struct TriColor {
        let normal: UIColor?
        let highlighted: UIColor?
        let disabled: UIColor?

        func color(isHighlighted: Bool, isEnabled: Bool) -> UIColor? {
            if !isEnabled { return disabled }
            else if isHighlighted { return highlighted }
            else { return normal }
        }
    }

    public struct Config {
        let borderWidth: CGFloat
        let borderColor: TriColor?
        let backgroundColor: TriColor
        let contextColor: TriColor
        let iconColor: TriColor

        static let primary = DesignButton.Config(
            borderWidth: 0,
            borderColor: nil,
            backgroundColor: .init(
                normal: .buttonPrimary,
                highlighted: .buttonPrimaryPressed,
                disabled: .buttonPrimaryDisabled
            ),
            contextColor: .init(
                normal: .textPrimaryInverse,
                highlighted: .textPrimaryInverse,
                disabled: .textTertiary
            ),
            iconColor: .init(
                normal: .iconActive,
                highlighted: .iconActive,
                disabled: .iconDisabled
            )
        )

        static let secondary = DesignButton.Config(
            borderWidth: 1,
            borderColor: .init(
                normal: .buttonOutline,
                highlighted: .buttonOutline,
                disabled: nil
            ),
            backgroundColor: .init(
                normal: nil,
                highlighted: .buttonSecondaryPressed,
                disabled: .buttonSecondaryDisabled
            ),
            contextColor: .init(
                normal: .textPrimary,
                highlighted: .textPrimary,
                disabled: .textTertiary
            ),
            iconColor: .init(
                normal: .iconActive,
                highlighted: .iconActive,
                disabled: .iconDisabled
            )
        )

        static let text = DesignButton.Config(
            borderWidth: 0,
            borderColor: nil,
            backgroundColor: .init(
                normal: nil,
                highlighted: .buttonTertiaryPressed,
                disabled: .buttonTertiaryDisabled
            ),
            contextColor: .init(
                normal: .textSecondary,
                highlighted: .textSecondary,
                disabled: .textTertiary
            ),
            iconColor: .init(
                normal: .iconActive,
                highlighted: .iconActive,
                disabled: .iconDisabled
            )
        )

        static let link = DesignButton.Config(
            borderWidth: 0,
            borderColor: nil,
            backgroundColor: .init(
                normal: nil,
                highlighted: .buttonTertiaryPressed,
                disabled: .buttonTertiaryDisabled
            ),
            contextColor: .init(
                normal: .textBrand,
                highlighted: .textSecondary,
                disabled: .textTertiary
            ),
            iconColor: .init(
                normal: .iconActive,
                highlighted: .iconActive,
                disabled: .iconDisabled
            )
        )
    }

    @IBInspectable public var isSecondary: Bool = false {
        didSet {
            updateColors()
        }
    }

    @IBInspectable public var isText: Bool = false {
        didSet {
            updateColors()
        }
    }

    @IBInspectable public var isLink: Bool = false {
        didSet {
            updateColors()
        }
    }

    @IBInspectable public var isRound: Bool = false {
        didSet {
            setNeedsLayout()
        }
    }

    @IBInspectable public var isCompact: Bool = false {
        didSet {
            setNeedsLayout()
            updateFont()
        }
    }

    @IBInspectable public var titleText: String? {
        get {
            title.text
        }
        set {
            title.text = newValue
            invalidateIntrinsicContentSize()
        }
    }

    @IBInspectable public var iconImage: UIImage? {
        get {
            icon.image
        }
        set {
            icon.image = newValue?.withRenderingMode(.alwaysTemplate)
        }
    }

    override public var localiseKey: String? {
        get { nil }
        set { titleText = newValue?.localised }
    }

    override public var isHighlighted: Bool {
        didSet { updateColors() }
    }

    override public var isEnabled: Bool {
        didSet { updateColors() }
    }

    public var customIconColor: UIColor? {
        didSet { updateColors() }
    }

    public var skipTextColor: Bool = false
    public var userInfo: Any?
    public var hasSetup = false

    public let title = UILabel()
    public let icon = UIImageView()

    public static let heightNormal: CGFloat = 48
    public static let heightCompact: CGFloat = 40

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override public func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    private func setup() {
        guard !hasSetup else { return }

        hasSetup = true

        icon.contentMode = .center
        icon.translatesAutoresizingMaskIntoConstraints = false
        addSubview(icon)

        title.textAlignment = .center
        title.translatesAutoresizingMaskIntoConstraints = false
        addSubview(title)

        layer.cornerRadius = DesignSystem.cornerRadiusSmall
        updateColors()
        updateFont()

        titleLabel?.isHidden = true
        titleLabel?.removeFromSuperview()
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        if isRound {
            icon.frame = bounds
            title.frame = .zero
            layer.cornerRadius = bounds.height / 2
        } else if let image = icon.image {
            let iconWidth = ceil(image.size.width)
            let labelWidth = ceil(title.sizeThatFits(.init(width: 9999, height: 9999)).width)
            let iconPadding: CGFloat = labelWidth > 0 ? 8 : 0
            let fullWidthNoMargin = iconWidth + iconPadding + labelWidth

            icon.frame = .init(
                x: (bounds.width - fullWidthNoMargin) / 2,
                y: 0,
                width: iconWidth,
                height: bounds.height
            )
            title.frame = .init(
                x: icon.frame.maxX + 8,
                y: 0,
                width: labelWidth,
                height: bounds.height
            )
        } else {
            icon.frame = .zero
            title.frame = bounds
        }
    }

    override public var intrinsicContentSize: CGSize {
        let height: CGFloat = isCompact ? Self.heightCompact : Self.heightNormal
        if isRound { return .init(width: height, height: height) }

        let hasIcon = icon.image != nil
        let iconWidth = ceil(icon.image?.size.width ?? 0)
        let labelWidth = ceil(title.sizeThatFits(.init(width: 9999, height: 9999)).width)
        let iconPadding: CGFloat = labelWidth > 0 ? 8 : 0
        let iconExtra = hasIcon ? iconWidth + iconPadding : 0
        let sideMargins: CGFloat = isCompact ? 8 : 16
        let fullWidth = sideMargins * 2 + iconExtra + labelWidth
        return .init(width: fullWidth, height: height)
    }

    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        let previous: UIUserInterfaceStyle = previousTraitCollection?.userInterfaceStyle ?? .unspecified
        if previous != traitCollection.userInterfaceStyle {
            updateColors()
        }
    }
}

public extension DesignButton {
    func updateColors() {
        let config: Config = isSecondary ? (isLink ? .link : .secondary) : (isText ? .text : .primary)
        layer.borderWidth = config.borderWidth
        layer.borderColor = config.borderColor?.color(
            isHighlighted: isHighlighted,
            isEnabled: isEnabled
        )?.cgColor
        backgroundColor = config.backgroundColor.color(
            isHighlighted: isHighlighted,
            isEnabled: isEnabled
        )

        if !skipTextColor {
            title.textColor = config.contextColor.color(
                isHighlighted: isHighlighted,
                isEnabled: isEnabled
            )
        }
        icon.tintColor = customIconColor ?? config.iconColor.color(
            isHighlighted: isHighlighted,
            isEnabled: isEnabled
        )
    }

    func updateFont() {
        title.font = isCompact ? .label2 : .body2
    }
}
