//  Created by Thinh Nguyen
//

import Foundation

public extension Result {
    var error: Error? {
        switch self {
        case let .success(success): return nil
        case let .failure(failure): return failure
        }
    }

    var value: Success? {
        switch self {
        case let .success(success): return success
        case let .failure(failure): return nil
        }
    }
}
