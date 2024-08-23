//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public extension Decodable {
    static func from(json: [String: Any]) -> Self? {
        guard let data = json.asJSONData else { return nil }
        return try? JSONDecoder().decode(Self.self, from: data)
    }
}
