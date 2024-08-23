//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public extension UIDevice {
    static var isSimulator: Bool {
        #if targetEnvironment(simulator)
            return true
        #else
            return false
        #endif
    }

    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)

        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children
            .reduce("") { identifier, element in
                guard let value = element.value as? Int8, value != 0 else { return identifier }

                return identifier + String(UnicodeScalar(UInt8(value)))
            }
        return identifier
    }()
}
