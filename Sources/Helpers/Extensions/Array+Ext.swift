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
