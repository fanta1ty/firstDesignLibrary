//  Created by Thinh Nguyen
//

import Foundation

public extension Dictionary {
    var asJSONData: Data? {
        try? JSONSerialization.data(withJSONObject: self, options: [])
    }

    var asPrettyJSONData: Data? {
        try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted])
    }
}

public extension Dictionary {
    func mapKeys<NewKey: Hashable>(_ transform: (Key) -> NewKey?) -> [NewKey: Value] {
        var newDict: [NewKey: Value] = [:]
        for (k, v) in self {
            guard let newKey = transform(k) else { continue }
            newDict[newKey] = v
        }
        return newDict
    }

    func merging(new: [Key: Result<Value?, Error>]) -> Self {
        var output: Self = [:]
        for (key, result) in new {
            switch result {
            case let .success(success):
                output[key] = success

            case .failure:
                output[key] = self[key]
            }
        }
        return output
    }
}

public extension Dictionary where Key == String {
    var withLowercasedKeys: [String: Value] {
        Self(map { ($0.key.lowercased(), $0.value) }) { _, new in
            new
        }
    }
}
