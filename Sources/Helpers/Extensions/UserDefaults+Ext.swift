//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public protocol FetchableFromUserDefaults {
    static func fetch(fromUserDefaults defaults: UserDefaults, key: String) -> Self?
}

public extension UserDefaults {
    enum Keys: String, CaseIterable {
        case appleLanguages = "AppleLanguages"
    }
}

public extension UserDefaults {
    static let `default`: UserDefaults = .standard
}

public extension UserDefaults {
    func fetch<Value: FetchableFromUserDefaults>(forKey key: String) -> Value? {
        Value.fetch(fromUserDefaults: self, key: key)
    }
}
