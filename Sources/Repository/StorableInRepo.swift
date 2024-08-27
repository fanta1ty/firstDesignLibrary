//  Created by Thinh Nguyen
//

import Foundation

public protocol StorableInRepo {
    static func repoDeserialise(data: Data) -> Self?

    func repoSerialise() -> Data?
}
