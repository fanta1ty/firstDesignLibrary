//  Created by Thinh Nguyen
//

import CommonCrypto
import CryptoKit
import Foundation

public extension Data {
    var asOAuthBase64String: String {
        base64EncodedString()
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
            .trimmingCharacters(in: .whitespaces)
    }

    var asHexString: String {
        var str = ""
        for byte in self {
            str.append(String(format: "%02x", byte))
        }
        return str
    }

    var asCrc16CcittFalse: String {
        var crc: UInt16 = 0xFFFF

        forEach { byte in
            crc = (crc >> 8 ^ crc << 8) & 0xFFFF
            crc ^= UInt16(byte) & 0xFF
            crc ^= (crc & 0xFF) >> 4
            crc ^= (crc << 12) & 0xFFFF
            crc ^= ((crc & 0xFF) << 5) & 0xFFFF
        }
        crc &= 0xFFFF
        return String(format: "%04X", crc)
    }

    var asString: String? {
        String(data: self, encoding: .utf8)
    }

    var asJSON: [AnyHashable: Any]? {
        let object = try? JSONSerialization.jsonObject(with: self, options: [])
        return object as? [AnyHashable: Any]
    }

    var asJSONArray: [[String: Any]]? {
        let object = try? JSONSerialization.jsonObject(with: self, options: [])
        return object as? [[String: Any]]
    }
}

public extension Data {
    static func secRandom(count: Int) -> Data {
        var buffer = [UInt8](repeating: 0, count: count)
        _ = SecRandomCopyBytes(kSecRandomDefault, count, &buffer)
        return Data(buffer)
    }
}

public extension Data {
    func sha256() -> Data {
        var buffer = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        withUnsafeBytes { body in
            _ = CC_SHA256(body.baseAddress, CC_LONG(count), &buffer)
        }
        return Data(buffer)
    }

    func deriveKeyPBKDFSHA256(
        salt: Data,
        keyBytes: Int = 32
    ) throws -> Data {
        var buffer = [UInt8](repeating: 0, count: keyBytes)

        try withUnsafeBytes { body in
            try salt.withUnsafeBytes { saltBody in
                let result = CCKeyDerivationPBKDF(
                    CCPBKDFAlgorithm(kCCPBKDF2),
                    body.baseAddress,
                    count,
                    saltBody.baseAddress,
                    salt.count,
                    CCPseudoRandomAlgorithm(kCCPRFHmacAlgSHA256),
                    10000,
                    &buffer,
                    buffer.count
                )

                guard result == kCCSuccess else {
                    throw Errors.ccKeyDerivationPBKDFFailed
                }
            }
        }

        return Data(buffer)
    }

    func asStringThrowing() throws -> String {
        guard let s = String(data: self, encoding: .utf8) else { throw Errors.couldNotConvertToString }
        return s
    }
}

extension Data: StorableInRepo {
    public func repoSerialise() -> Data? {
        self
    }

    public static func repoDeserialise(data: Data) -> Data? {
        data
    }
}
