//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public extension URL {
    var modificationDate: Date? {
        do {
            let attr = try FileManager.default.attributesOfItem(atPath: path)
            return attr[FileAttributeKey.modificationDate] as? Date
        } catch {
            return nil
        }
    }
}
