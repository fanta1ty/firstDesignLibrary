//  Created by Thinh Nguyen
//

import Combine
import Foundation
import UIKit

public protocol InputCellDelegate: AnyObject {
    func input(cell: InputCell, didSelectDropDown input: InputView)
}

public final class InputCell: UITableViewCell {
    public static let id = "InputCell"

    public let field = InputView()
    public var top: NSLayoutConstraint?
    public var bottom: NSLayoutConstraint?

    private var cancellables: [AnyCancellable] = []

    public var didChange: ((String) -> Void)?
    public var didSelectDropDown: (() -> Void)?
    public var didEndEditing: (() -> Void)?

    override public init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .uiBackgroundPrimary

        field.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(field)

        top = field.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12)
        top?.isActive = true

        bottom = field.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        bottom?.isActive = true

        NSLayoutConstraint.activate([
            field.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            field.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
        ])
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(config: InputRowConfig) {
        field.labelText = config.label
        field.isEnabled = config.isEnabled
        field.hasEndButton = config.dropdownOptions != nil
        field.state = config.error == nil ? .normal : .error
        field.helperText = config.error?.localizedDescription ?? ""

        let keyboardType = config.keyboardType ?? .default
        field.keyboardType = keyboardType
        field.inputAccessoryViewIsClose = !keyboardType.isReturnAvailable
        field.autoCapitalizationForAllCharacters = config.autoCapitalizationForAllCharacters
        top?.constant = config.isFirstRow ? 0 : 12

        config.value
            .sink(receiveValue: { [weak self] in
                guard let self else { return }
                self.field.setFieldText($0, animated: false)
            })
            .store(in: &cancellables)

        didChange = config.setter
    }

    override public func prepareForReuse() {
        super.prepareForReuse()

        cancellables.removeAll()

        field.state = .normal
        field.helperText = ""
        field.keyboardType = .default
        field.isEnabled = true
        field.hasEndButton = false
        field.inputAccessoryViewIsClose = false
        field.endButtonImage = .caretDown

        didChange = nil
        didSelectDropDown = nil
        didEndEditing = nil
        top?.constant = 12
        bottom?.constant = -12
    }
}

extension InputCell: InputViewDelegate {
    public func input(viewDidSelectEndButton _: InputView) {
        didSelectDropDown?()
    }

    public func input(view _: InputView, textDidChange text: String) {
        didChange?(text)
    }

    public func input(viewDidEndEditting _: InputView) {
        didEndEditing?()
    }
}
