//  Created by Thinh Nguyen
//

import Foundation

// MARK: - DesignAlertType

public enum DesignAlertType {
    case success(String, String),
         error(title: String, message: String = "")
}

extension DesignAlertType {
    var leftActionText: String {
        switch self {
        case .success: return "Done"
        case .error: return "Done"
        }
    }

    var rightActionText: String {
        switch self {
        case .success: return "Cancel"
        case .error: return "Cancel"
        }
    }
}

extension DesignAlertType {
    func title() -> String {
        switch self {
        case let .success(title, _): return title
        case let .error(title: title, _): return title
        }
    }

    func message() -> String {
        switch self {
        case let .success(title, _): return title
        case let .error(_, message: message): return message
        }
    }

    func height(
        isShowVerticalButton: Bool = false
    ) -> CGFloat {
        switch self {
        case .success:
            return isShowVerticalButton ? 220 : 150
        case .error:
            return isShowVerticalButton ? 220 : 150
        }
    }
}
