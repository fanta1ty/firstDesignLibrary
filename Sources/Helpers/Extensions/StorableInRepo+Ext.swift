//  Created by Thinh Nguyen
//

import Foundation

extension StorableInRepo where Self: Codable {
    func repoSerialise() -> Data? {
        try? JSONEncoder().encode(self)
    }

    static func repoDeserialise(data: Data) -> Self? {
        try? JSONDecoder().decode(Self.self, from: data)
    }
}
