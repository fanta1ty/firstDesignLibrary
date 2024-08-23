//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public extension Bundle {
    var version: String {
        infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }

    var build: String {
        infoDictionary?["CFBundleVersion"] as? String ?? ""
    }

    var versionAndBuild: String {
        "\(version) (\(build))"
    }
}
