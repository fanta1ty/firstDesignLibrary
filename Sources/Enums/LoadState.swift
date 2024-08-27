//  Created by Thinh Nguyen
//

import Foundation

public enum LoadState<Value> {
    case none,
         loading,
         loaded(Value),
         error(Error)
}

public extension LoadState {
    var value: Value? {
        switch self {
        case let .loaded(value): return value
        default: return nil
        }
    }

    var error: Error? {
        switch self {
        case let .error(error): return error
        default: return nil
        }
    }

    var isLoading: Bool {
        switch self {
        case .loading: return true
        default: return false
        }
    }

    var isLoaded: Bool {
        switch self {
        case .loaded: return true
        default: return false
        }
    }

    var isError: Bool {
        switch self {
        case .error: return true
        default: return false
        }
    }

    var isCompleted: Bool {
        switch self {
        case .error, .loaded: return true
        default: return false
        }
    }

    var isNone: Bool {
        switch self {
        case .none: return true
        default: return false
        }
    }

    var isEmptyDataSet: Bool {
        switch self {
        case .none, .loading: return false
        case let .loaded(value):
            if let array = value as? [Any] {
                return array.isEmpty
            } else {
                return false
            }
        case .error: return true
        }
    }
}

public extension LoadState {
    func map<T>(_ transform: (Value) -> T) -> LoadState<T> {
        switch self {
        case .none: return .none
        case .loading: return .loading
        case let .loaded(value): return .loaded(transform(value))
        case let .error(error): return .error(error)
        }
    }
}

extension LoadState: Equatable where Value: Equatable {
    public static func == (lhs: LoadState<Value>, rhs: LoadState<Value>) -> Bool {
        switch (lhs, rhs) {
        case (.none, .none), (.loading, .loading):
            return true
        case let (.loaded(value1), .loaded(value2)):
            return value1 == value2
        case let (.error(error1), .error(error2)):
            return error1.localizedDescription == error2.localizedDescription
        default:
            return false
        }
    }
}
