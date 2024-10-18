//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public enum DesignSystem {
    static let cornerRadiusTiny: CGFloat = 2
    static let cornerRadiusSmall: CGFloat = 4
    static let cornerRadiusMedium: CGFloat = 8
    static let cornerRadiusSemiLarge: CGFloat = 12
    static let cornerRadiusLarge: CGFloat = 16
    static let cornerRadiusLarger: CGFloat = 24

    public enum Status {
        case info, warning, error, success, general, text

        var icon: UIImage {
            switch self {
            case .info, .general, .text:
                return .statusInfo
            case .warning:
                return .statusWarning
            case .error:
                return .statusError
            case .success:
                return .statusSuccess
            }
        }

        var color: UIColor {
            switch self {
            case .info:
                return .statusInfo
            case .warning:
                return .statusWarning
            case .error:
                return .statusNegative
            case .success:
                return .statusPositive
            case .general, .text:
                return .textPrimary
            }
        }

        var backgroundColor: UIColor {
            switch self {
            case .info:
                return .statusInfoBackground
            case .warning:
                return .statusWarningBackground
            case .error:
                return .statusNegativeBackground
            case .success:
                return .statusPositiveBackground
            case .general:
                return .buttonSecondaryPressed
            case .text:
                return .uiBackgroundPrimary
            }
        }

        var reverseBackgroundColor: UIColor {
            switch self {
            case .error:
                return .statusNegativeLight
            default:
                return backgroundColor
            }
        }
    }
}
