//  Created by Thinh Nguyen
//

import Foundation

public final class RepositoryManager {
    let localiseLanguage = RepoItem<String>(fileKey: "localiseLanguage", migratedValue: "localise_language")
    let interfaceStyle = RepoItem<Int>(fileKey: "interfaceStyle", migrateFromUserDefaultsKey: "interfaceStyle")
}

public extension RepositoryManager {
    func startup() {}

    func reset() {
        interfaceStyle.reset()
        localiseLanguage.reset()
    }
}
