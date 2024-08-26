//  Created by Thinh Nguyen
//

import Foundation
import UIKit

public extension String {
    var asYmdhmss: Date? {
        DateFormatter.ymdhmss.date(from: self)
    }

    var initials: String {
        split(separator: " ")
            .prefix(2)
            .compactMap { $0.first }
            .map { String($0) }
            .joined()
            .uppercased()
    }

    var nilIfEmpty: String? {
        isEmpty ? nil : self
    }

    var formattedPAN: String {
        var out = ""
        for (i, c) in enumerated() {
            if i > 0 && i % 4 == 0 {
                out.append("-")
            }
            out.append(c)
        }
        return out
    }

    var formattedExpiry: String {
        guard count == 4 else { return self }

        let y = String(prefix(2))
        let m = String(suffix(2))
        return m + "/" + y
    }

    var removeingLeadingZeros: String {
        var s = self
        while s.hasPrefix("0") && s.count > 1 {
            s.removeFirst()
        }
        return s
    }

    var lowercasedFirst: String {
        guard !isEmpty else { return self }
        return first!.uppercased() + self[index(startIndex, offsetBy: 1)...]
    }

    var uppercasedFirst: String {
        guard !isEmpty else { return self }
        return first!.lowercased() + self[index(startIndex, offsetBy: 1)...]
    }

    var wordsFromCamel: String {
        var lastWasCaps: Bool?
        var out = ""
        for c in self {
            let thisIsCaps = c.isUppercase
            if let lastWasCaps {
                if thisIsCaps && !lastWasCaps {
                    out.append(" ")
                }
                out.append(c)
            } else {
                out.append(c.uppercased())
            }
            lastWasCaps = thisIsCaps
        }
        return out
    }

    var unescaped: String {
        let mapping = [
            "\\\"": "\"",
            "\\\'": "\'",
            "\\\n": "\n",
            "\\\t": "\t",
        ]
        var output = self
        for (key, value) in mapping {
            output = output.replacingOccurrences(of: key, with: value)
        }
        return output
    }

    var asUrl: URL? {
        URL(string: self)
    }

    var asDouble: Double? {
        Double(self)
    }

    var asColor: UIColor? {
        UIColor(hexString: self)
    }

    var trimmed: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var removingHTMLEntities: String {
        replacingOccurrences(of: "<p>", with: "")
            .replacingOccurrences(of: "</p>", with: "")
            .replacingOccurrences(of: "&nbsp;", with: " ")
            .replacingOccurrences(of: "&amp;", with: "&")
            .replacingOccurrences(of: "&lt", with: "<")
            .replacingOccurrences(of: "&gt", with: ">")
            .replacingOccurrences(of: "<br>", with: "")
    }

    var htmlToAttributeString: NSMutableAttributedString? {
        if let data = data(using: .utf8),
           let attributedString = try? NSMutableAttributedString(
               data: data,
               options: [
                   .documentType: NSAttributedString.DocumentType.html,
                   .characterEncoding: String.Encoding.utf8.rawValue,
               ],
               documentAttributes: nil
           ) { return attributedString }
        else { return nil }
    }

    var prefixSuffixWithBase64: String {
        guard let data = data(using: .utf8) else { return self }
        let base64 = data.base64EncodedString()
        return "base64#\(base64)#base64"
    }

    var asData: Data? {
        data(using: .utf8)
    }

    var asInt: Int? {
        Int(self)
    }

    var localised: String {
        Self.localised(code: self)
    }
}

public extension String {
    static func randomDigits(length: Int) -> String {
        var s = ""
        for _ in 0 ..< length {
            s += String(arc4random_uniform(10))
        }
        return s
    }

    static func repoDeserialise(data: Data) -> String? {
        data.asString
    }

    static func localised(code: String) -> String {
        NSLocalizedString(code, comment: "")
    }
}

public extension String {
    func attributedText(
        highlighted: String,
        color: UIColor = .textBrand,
        font: UIFont? = nil
    ) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: self)
        let range = attributedText.mutableString.range(of: highlighted)
        attributedText.addAttribute(.foregroundColor, value: color, range: range)

        if let font {
            attributedText.addAttribute(.font, value: font, range: range)
        }
        return attributedText
    }

    func asDataFromHex() -> Data {
        var previous: UInt8?
        var arr: [UInt8] = []
        for c in self {
            guard let value = c.parseHex else { continue }
            if let p = previous {
                arr.append((p << 4) + value)
                previous = nil
            } else {
                previous = value
            }
        }
        return Data(arr)
    }

    func substring(fromStartIndex start: Int, endIndex end: Int) -> String? {
        guard start >= 1, start <= count else { return nil }
        guard end >= 0, end <= count, end > start else { return nil }

        let startIndex = index(startIndex, offsetBy: start)
        let endIndex = index(self.startIndex, offsetBy: end)
        let range = startIndex ..< endIndex
        return String(self[range])
    }

    func substring(between: String, andEnd: String) -> String? {
        guard let rangeA = range(of: between) else { return nil }
        let remainder = self[rangeA.upperBound...]

        guard let rangeB = remainder.range(of: andEnd) else { return nil }
        let value = remainder[..<rangeB.lowerBound]

        return String(value)
    }

    func asDataThrowing() throws -> Data {
        guard let d = data(using: .utf8) else { throw Errors.couldNotConvertToData }
        return d
    }
}

extension String: StorableInRepo {
    public func repoSerialise() -> Data? {
        asData
    }
}

extension String: FetchableFromUserDefaults {
    public static func fetch(fromUserDefaults defaults: UserDefaults, key: String) -> String? {
        defaults.string(forKey: key)
    }
}
