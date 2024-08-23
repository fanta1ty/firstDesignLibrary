//  Created by Thinh Nguyen
//

import Foundation

public extension Character {
    var parseHex: UInt8? {
        guard let ascii = asciiValue else { return nil }

        let _0: UInt8 = 48
        let _9: UInt8 = 57
        let a: UInt8 = 97
        let f: UInt8 = 102
        let A: UInt8 = 65
        let F: UInt8 = 70
        if _0 <= ascii, ascii <= _9 {
            return ascii - _0
        }
        if a <= ascii, ascii <= f {
            return ascii - a + 10
        }
        if A <= ascii, ascii <= F {
            return ascii - A + 10
        }
        return nil
    }
}
