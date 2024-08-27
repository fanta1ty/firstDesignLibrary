//  Created by Thinh Nguyen
//

import Combine
import Foundation

public final class RepoItem<Value: StorableInRepo> {
    public let fileKey: String

    public var state: RepoState<Value> {
        _state
    }

    @Published private var _state: RepoState<Value> {
        didSet {
            let stateCopy = state
            let fileKeyCopy = fileKey
            DispatchQueue.global(qos: .utility).async {
                RepoStorage.save(data: stateCopy, fileKey: fileKeyCopy)
            }
        }
    }

    public var value: Value? {
        get { state.value }
        set {
            if let newValue {
                setLoaded(value: newValue)
            } else {
                reset()
            }
        }
    }

    public func setLoaded(value: Value) {
        _state = .loaded(value, Date())
    }

    public func reset() {
        _state = .none
    }

    public func setLoading() {
        _state = .loading(value, _state.fetched)
    }

    public func setError(
        _ e: Error,
        completion _: (() -> Void)? = nil
    ) {
        _state = .error(value, _state.fetched, e)
    }

    public init(
        fileKey: String,
        migratedValue: Value? = nil
    ) {
        self.fileKey = fileKey

        if let migratedValue {
            _state = .loaded(migratedValue, .distantPast)
            RepoStorage.save(data: state, fileKey: fileKey)
        } else {
            _state = RepoStorage.load(fileKey: fileKey)
        }
    }
}
