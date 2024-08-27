//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size)
            .map { Array(self[$0 ..< Swift.min($0 + size, count)]) }
    }
}

public extension Array where Element: Hashable {
    var unique: [Element] {
        var set = Set<Element>()
        return filter {
            set.insert($0).inserted
        }
    }
}

public extension Array where Element == UInt8 {
    var deobfuscatedKey: Data {
        let a = prefix(count / 2)
        let b = suffix(count / 2)
        let k = zip(a, b).map(^)
        return Data(k)
    }
}

extension Array: StorableInRepo where Element: StorableInRepo {
    public static func repoDeserialise(data: Data) -> [Element]? {
        guard let array = try? JSONDecoder().decode([Data].self, from: data) else {
            return nil
        }

        return array.compactMap { Element.repoDeserialise(data: $0) }
    }

    public func repoSerialise() -> Data? {
        guard let data = try? JSONEncoder()
            .encode(compactMap { $0.repoSerialise() }) else { return nil }

        return data
    }
}
