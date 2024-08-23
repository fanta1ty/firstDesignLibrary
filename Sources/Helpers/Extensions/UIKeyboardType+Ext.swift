//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public extension UIKeyboardType {
    var isReturnAvailable: Bool {
        switch self {
        case .default:
            return true
        case .asciiCapable:
            return true
        case .numbersAndPunctuation:
            return true
        case .URL:
            return true
        case .numberPad:
            return false
        case .phonePad:
            return false
        case .namePhonePad:
            return true
        case .emailAddress:
            return true
        case .decimalPad:
            return false
        case .twitter:
            return true
        case .webSearch:
            return true
        case .asciiCapableNumberPad:
            return false
        case .alphabet:
            return false
        @unknown default:
            return true
        }
    }
}
