//  Created by Thinh Nguyen
//

import CryptoKit
import Foundation

public enum RepoKey {
    private static let account = "RepositoryKey"
    private static let obfuscatedKeySalt: [UInt8] = [
        107, 254, 72, 79, 229, 195, 151, 63, 47, 161, 135, 136,
        164, 172, 199, 7, 17, 234, 138, 219, 139, 99, 191, 104,
        27, 215, 191, 139, 55, 132, 165, 43, 150, 241, 83, 177,
        225, 6, 13, 90, 99, 211, 155, 4, 7, 249, 135, 150, 72,
        112, 187, 147, 252, 107, 189, 87, 238, 254, 121, 84,
        28, 86, 9, 209,
    ]

    public static func load() -> SymmetricKey? {
        guard let rawKeyData = try? KeychainHelper.get(account: account) else { return nil }

        let salt = obfuscatedKeySalt.deobfuscatedKey
        guard let key = try? rawKeyData.deriveKeyPBKDFSHA256(salt: salt) else { return nil }
        return SymmetricKey(data: key)
    }

    public static func loadOrGenerate() -> SymmetricKey? {
        if let key = load() {
            return key
        } else {
            try? KeychainHelper.set(value: Data.secRandom(count: 32), account: account)
            return load()
        }
    }

    public static func reset() {
        try? KeychainHelper.delete(account: account)
    }
}
