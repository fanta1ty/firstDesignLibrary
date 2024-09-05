//  Created by Thinh Nguyen
//

import Combine
import Foundation
import UIKit

public struct InputRowConfig {
    public let id: Int
    public let label: String
    public let isEnabled: Bool
    public let value: AnyPublisher<String, Never>
    public let setter: ((String) -> Void)?
    public let dropdownOptions: [(String, String)]?
    public let selectedDropdownOption: (() -> String?)?
    public let error: LocalizedError?
    public let keyboardType: UIKeyboardType?
    public let autoCapitalizationForAllCharacters: Bool
    public let isFirstRow: Bool

    public init(
        id: Int,
        label: String,
        isEnabled: Bool,
        value: AnyPublisher<String, Never>,
        setter: ((String) -> Void)?,
        dropdownOptions: [(String, String)]? = nil,
        selectedDropdownOption: (() -> String?)? = nil,
        error: LocalizedError? = nil,
        keyboardType: UIKeyboardType? = nil,
        autoCapitalizationForAllCharacters: Bool = false,
        isFirstRow: Bool = false
    ) {
        self.id = id
        self.label = label
        self.isEnabled = isEnabled
        self.value = value
        self.setter = setter
        self.dropdownOptions = dropdownOptions
        self.selectedDropdownOption = selectedDropdownOption
        self.error = error
        self.keyboardType = keyboardType
        self.autoCapitalizationForAllCharacters = autoCapitalizationForAllCharacters
        self.isFirstRow = isFirstRow
    }
}
