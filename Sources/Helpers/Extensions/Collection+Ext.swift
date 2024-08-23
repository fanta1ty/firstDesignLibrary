//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public protocol HasStringID {
    var id: String { get }
}

public extension Collection where Element: HasStringID {
    func asDiffableDataSourceSnapshot() -> NSDiffableDataSourceSnapshot<Int, String> {
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(map { $0.id })
        return snapshot
    }
}

public extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
