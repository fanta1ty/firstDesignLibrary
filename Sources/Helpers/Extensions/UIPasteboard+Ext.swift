//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public extension UIPasteboard {
    static let defaultExpiry = 5 * 60

    func set(string: String?, expiredAfter: Int = defaultExpiry) {
        guard let string else {
            self.string = nil
            return
        }

        var options: [UIPasteboard.OptionsKey: Any] = [.localOnly: true]
        if expiredAfter > 0 {
            options[.expirationDate] = Date().addingTimeInterval(TimeInterval(expiredAfter))
        }
        setItems([[UIPasteboard.typeAutomatic: string]], options: options)
    }
}
