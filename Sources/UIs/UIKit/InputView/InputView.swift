//  Created by Thinh Nguyen
//

import Foundation
import UIKit

private enum K {
    static let scale = UIFont.label2.lineHeight / UIFont.body2.lineHeight
    static let labelUp = CGAffineTransform(scaleX: scale, y: scale)
}

public class InputView: UIView {
    private let outerStack = UIStackView()
    private let container = HighlightControl()
    private let containerStack = UIStackView()
    private let customIcon = UIImageView()
    private let labelFieldContainer = UIView()
    private let label = UILabel()
    private let field = UITextField()
    private let endButtonIcon = UIImageView(image: .caretDown)
    private let statusIcon = UIImageView()
    private let helper = UILabel()
    private let divider = UIView()

    private var labelTop: NSLayoutConstraint?
    private var labelCenter: NSLayoutConstraint?

    public weak var delegate: InputViewDelegate?

    @IBInspectable public var isEnabled: Bool {
        get { field.isEnabled }
        set {
            field.isEnabled = newValue
            container.isEnabled = newValue
            updateStyles()
        }
    }

    @IBInspectable public var isDividerAlwaysVisible: Bool = true {
        didSet {
            updateStyles()
        }
    }

    @IBInspectable public var hasEndButton: Bool {
        get { !endButtonIcon.isHidden }
        set {
            endButtonIcon.isHidden = !newValue
            container.highlightColor = newValue ? .uiHighlighted : innerBackgroundColor
            field.isUserInteractionEnabled = !newValue
            setNeedsUpdateConstraints()
        }
    }

    @IBInspectable public var endButtonImage: UIImage? {
        get { endButtonIcon.image }
        set { endButtonIcon.image = newValue?.withRenderingMode(.alwaysTemplate) }
    }

    public var innerBackgroundColor: UIColor? {
        get { container.normalColor }
        set {
            container.normalColor = newValue
            updateStyles()
        }
    }

    public var textFieldFont: UIFont = .body2 {
        didSet {
            updateFonts()
        }
    }

    override public var isFirstResponder: Bool {
        field.isFirstResponder
    }

    public var maxLength: Int?

    public enum State {
        case normal,
             error,
             success

        var icon: UIImage? {
            switch self {
            case .normal: return nil
            case .error: return .statusError
            case .success: return .statusSuccess
            }
        }
    }

    public var state: InputView.State = .normal {
        didSet {
            updateStyles()
            let icon = state.icon
            statusIcon.image = icon
            statusIcon.isHidden = icon == nil
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

    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        let previous: UIUserInterfaceStyle = previousTraitCollection?.userInterfaceStyle ?? .unspecified
        if previous != traitCollection.userInterfaceStyle {
            updateStyles()
        }
    }

    override public var intrinsicContentSize: CGSize {
        .init(width: 160, height: 104)
    }

    override public func updateConstraints() {
        super.updateConstraints()

        let isUp = field.isFirstResponder || !(field.text ?? "").isEmpty
        updateLabel(isUp: isUp, animated: false)
    }

    override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        if view === field, field.isFirstResponder {
            return field
        } else if view === containerStack || view === labelFieldContainer {
            return container
        }
        return view
    }

    func setup() {
        outerStack.axis = .vertical
        outerStack.spacing = 16
        outerStack.alignment = .fill
        outerStack.distribution = .fill
        outerStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(outerStack)

        NSLayoutConstraint.activate([
            outerStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            outerStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            outerStack.topAnchor.constraint(equalTo: topAnchor),
            outerStack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        container.addTarget(self, action: #selector(didSelect), for: .touchUpInside)
        container.translatesAutoresizingMaskIntoConstraints = false
        outerStack.addArrangedSubview(container)

        NSLayoutConstraint.activate([
            container.heightAnchor.constraint(equalToConstant: 72),
        ])

        containerStack.axis = .horizontal
        containerStack.spacing = 8
        containerStack.alignment = .fill
        containerStack.distribution = .fill
        containerStack.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(containerStack)

        NSLayoutConstraint.activate([
            containerStack.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            containerStack.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            containerStack.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            containerStack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16),
        ])

        customIcon.isHidden = true
        customIcon.tintColor = .icon
        customIcon.contentMode = .center
        customIcon.setContentHuggingPriority(.required, for: .horizontal)
        customIcon.translatesAutoresizingMaskIntoConstraints = false
        containerStack.addArrangedSubview(customIcon)

        label.font = .body2
        label.textColor = .textTertiary
        label.layer.anchorPoint = .init(x: 0, y: 0.5)
        label.translatesAutoresizingMaskIntoConstraints = false
        labelFieldContainer.addSubview(label)
        labelTop = label.topAnchor.constraint(equalTo: labelFieldContainer.topAnchor)
        labelCenter = label.centerYAnchor.constraint(equalTo: labelFieldContainer.centerYAnchor)
        labelCenter?.isActive = true

        NSLayoutConstraint.activate([
            label.widthAnchor.constraint(equalTo: labelFieldContainer.widthAnchor),
            label.centerXAnchor.constraint(equalTo: labelFieldContainer.leadingAnchor),
        ])

        field.font = .body2
        field.textColor = .textPrimary
        field.autocorrectionType = .no
        field.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        labelFieldContainer.addSubview(field)

        NSLayoutConstraint.activate([
            field.bottomAnchor.constraint(equalTo: labelFieldContainer.bottomAnchor),
            field.leadingAnchor.constraint(equalTo: labelFieldContainer.leadingAnchor),
            field.trailingAnchor.constraint(equalTo: labelFieldContainer.trailingAnchor),
        ])

        labelFieldContainer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        labelFieldContainer.translatesAutoresizingMaskIntoConstraints = false
        labelFieldContainer.heightAnchor.constraint(equalToConstant: 40).isActive = true
        containerStack.addArrangedSubview(labelFieldContainer)

        endButtonIcon.image = .caretDown.withRenderingMode(.alwaysTemplate)
        endButtonIcon.isHidden = true
        endButtonIcon.contentMode = .center
        endButtonIcon.setContentHuggingPriority(.required, for: .horizontal)
        endButtonIcon.translatesAutoresizingMaskIntoConstraints = false
        containerStack.addArrangedSubview(endButtonIcon)

        statusIcon.tintColor = .icon
        statusIcon.isHidden = true
        statusIcon.contentMode = .center
        statusIcon.setContentHuggingPriority(.required, for: .horizontal)
        statusIcon.translatesAutoresizingMaskIntoConstraints = false
        containerStack.addArrangedSubview(statusIcon)

        divider.backgroundColor = nil
        divider.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(divider)

        NSLayoutConstraint.activate([
            divider.heightAnchor.constraint(equalToConstant: 1),
            divider.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            divider.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: container.trailingAnchor),
        ])

        helper.font = .body3
        helper.numberOfLines = 0
        helper.isHidden = true
        outerStack.addArrangedSubview(helper)

        updateStyles()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textDidChange),
            name: UITextField.textDidChangeNotification,
            object: field
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
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

    public func updateStyles() {
        divider.backgroundColor = dividerColor()
        label.textColor = isEnabled ? .textTertiary : .textDisabled
        field.textColor = isEnabled ? .textPrimary : .textDisabled
        endButtonIcon.tintColor = isEnabled ? .icon : .iconDisabled
        helper.textColor = state == .error ? .textNegative : .textTertiary
    }

    public func dividerColor() -> UIColor? {
        switch state {
        case .normal: break
        case .error: return .borderNegative
        case .success: return .borderPositive
        }

        if field.isFirstResponder { return .borderFocus }
        return isDividerAlwaysVisible && isEnabled ? .border : nil
    }

    public func updateFonts() {
        field.font = textFieldFont
    }

    public func updateCursorToEnd() {
        DispatchQueue.main.async {
            let newPosition = self.field.endOfDocument
            self.field.selectedTextRange = self.field.textRange(from: newPosition, to: newPosition)
        }
    }

    @objc private func didSelect() {
        if hasEndButton {
            delegate?.input(viewDidSelectEndButton: self)
        } else {
            if isEnabled {
                field.becomeFirstResponder()
            }
        }
    }

    @objc private func textDidChange() {
        delegate?.input(view: self, textDidChange: field.text ?? "")
    }

    public func fieldBecomeFirstResponder() {
        field.becomeFirstResponder()
    }

    public func fieldResignFirstResponder() {
        field.resignFirstResponder()
    }
}

extension InputView: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_: UITextField) {
        divider.backgroundColor = dividerColor()
        updateLabel(isUp: true, animated: true)
    }

    public func textFieldDidEndEditing(_ textField: UITextField, reason _: UITextField.DidEndEditingReason) {
        divider.backgroundColor = dividerColor()
        let isUp = !(textField.text ?? "").isEmpty
        updateLabel(isUp: isUp, animated: true)
        delegate?.input(viewDidEndEditting: self)
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let maxLength else { return true }
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)
        return newString.count <= maxLength
    }
}

public extension InputView {
    var fieldText: String { field.text ?? "" }

    func setFieldText(
        _ newValue: String,
        animated: Bool
    ) {
        let wasUp = field.isFirstResponder || !(field.text ?? "").isEmpty
        let isNowUp = field.isFirstResponder || !newValue.isEmpty
        field.text = newValue

        if animated, wasUp, !isNowUp {
            updateLabel(isUp: false, animated: animated)
        } else if animated, !wasUp, isNowUp {
            updateLabel(isUp: true, animated: animated)
        } else {
            setNeedsUpdateConstraints()
        }
    }

    var labelText: String {
        get { label.text ?? "" }
        set {
            label.text = newValue
            field.accessibilityIdentifier = newValue
        }
    }

    var helperText: String {
        get { helper.text ?? "" }
        set {
            helper.text = newValue
            helper.isHidden = newValue.isEmpty
        }
    }

    var customIconImage: UIImage? {
        get { customIcon.image }
        set {
            customIcon.image = newValue?.withRenderingMode(.alwaysTemplate)
            customIcon.isHidden = newValue == nil
        }
    }

    var keyboardType: UIKeyboardType {
        get { field.keyboardType }
        set { field.keyboardType = newValue }
    }

    var fieldInputAccessoryView: UIView? {
        get { field.inputAccessoryView }
        set { field.inputAccessoryView = newValue }
    }

    var fieldIsFirstResponder: Bool {
        field.isFirstResponder
    }

    var inputAccessoryViewIsClose: Bool {
        get { fatalError() }
        set {
            if newValue {
                let tool = UIToolbar()
                tool.items = [
                    UIBarButtonItem(systemItem: .flexibleSpace),
                    UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didSelectAccessoryClose)),
                ]
                tool.sizeToFit()
                field.inputAccessoryView = tool
            } else {
                field.inputAccessoryView = nil
            }
        }
    }

    @objc private func didSelectAccessoryClose() {
        field.resignFirstResponder()
    }

    var prefix: UIView? {
        get {
            let first = containerStack.arrangedSubviews.first
            return first === customIcon ? nil : first
        }
        set {
            if let currentPrefix = self.prefix {
                containerStack.removeArrangedSubview(currentPrefix)
            }
            if let newValue {
                newValue.setContentHuggingPriority(.required, for: .horizontal)
                newValue.translatesAutoresizingMaskIntoConstraints = false
                containerStack.insertArrangedSubview(newValue, at: 0)
            }
        }
    }

    var fieldLastBaselineAnchor: NSLayoutYAxisAnchor {
        field.lastBaselineAnchor
    }

    var fieldHasSpellCheckCapitalisationEtc: Bool {
        get { field.spellCheckingType == .yes }
        set {
            field.autocapitalizationType = newValue ? .sentences : .none
            field.spellCheckingType = newValue ? .yes : .no
            field.smartQuotesType = newValue ? .yes : .no
            field.smartDashesType = newValue ? .yes : .no
        }
    }

    var autoCapitalizationForAllCharacters: Bool {
        get {
            return field.autocapitalizationType == .allCharacters
        }
        set {
            field.autocapitalizationType = newValue ? .allCharacters : .none
        }
    }
}
