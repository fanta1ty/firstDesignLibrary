//  Created by Thinh Nguyen
//

import Foundation

extension RepoItem where Value: FetchableFromUserDefaults {
    convenience init(
        fileKey: String,
        migrateFromUserDefaultsKey: String
    ) {
        let value: Value? = UserDefaults.default.fetch(forKey: migrateFromUserDefaultsKey)
        if value != nil {
            UserDefaults.default.removeObject(forKey: migrateFromUserDefaultsKey)
            UserDefaults.default.synchronize()
        }
        self.init(fileKey: fileKey, migratedValue: value)
    }
}
