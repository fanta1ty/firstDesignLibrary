//  Created by Thinh Nguyen
//

import Foundation

public enum Errors: Error {
    case keychain,
         ccKeyDerivationPBKDFFailed,
         couldNotConvertToData,
         couldNotConvertToString
}
