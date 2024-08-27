//  Created by Thinh Nguyen
//

import Foundation

public enum RepoState<Value: StorableInRepo> {
    case none,
         loading(Value?, Date?),
         loaded(Value, Date),
         error(Value?, Date?, Error)
}

public extension RepoState {
    var value: Value? {
        switch self {
        case .none: return nil
        case let .loading(value, _): return value
        case let .loaded(value, _): return value
        case let .error(value, _, _): return value
        }
    }

    var fetched: Date? {
        switch self {
        case .none: return nil
        case let .loading(_, date): return date
        case let .loaded(_, date): return date
        case let .error(_, date, _): return date
        }
    }

    var isLoading: Bool {
        switch self {
        case .loading: return true
        default: return false
        }
    }

    var isCompleted: Bool {
        switch self {
        case .error, .loaded: return true
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

    var isDueForReload: Bool {
        switch self {
        case .none, .error: return true
        case let .loading(_, date):
            if let date {
                return date < Date(timeIntervalSinceNow: -60 * 60)
            } else {
                return true
            }
        case let .loaded(_, date): return date < Date(timeIntervalSinceNow: -60 * 60)
        }
    }

    var asLoadState: LoadState<Value> {
        if let value {
            return .loaded(value)
        }
        switch self {
        case .none: return .none
        case .loading: return .loading
        case let .loaded(value, _): return .loaded(value)
        case let .error(_, _, error): return .error(error)
        }
    }
}
