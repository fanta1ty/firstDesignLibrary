//  Created by Thinh Nguyen
//

import CryptoKit
import Foundation

public enum RepoStorage {
    private static var cachedKey = RepoKey.loadOrGenerate()

    private static func url(forFileKey: String) -> URL? {
        let library = try? FileManager.default.url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: false)

        guard let library else { return nil }

        let fileName = "Repository.\(forFileKey).dat"

        return URL(fileURLWithPath: fileName, relativeTo: library)
    }

    static func load<Value: StorableInRepo>(fileKey: String) -> RepoState<Value> {
        guard let key = cachedKey else { return .none }
        guard let url = url(forFileKey: fileKey) else { return .none }
        guard let raw = try? Data(contentsOf: url) else { return .none }
        guard let box = try? AES.GCM.SealedBox(combined: raw) else { return .none }
        guard let clear = try? AES.GCM.open(box, using: key) else { return .none }
        guard let value = Value.repoDeserialise(data: clear) else { return .none }

        let date = url.modificationDate ?? Date().addingTimeInterval(-60 * 60 * 24)
        return .loaded(value, date)
    }

    static func save<Value: StorableInRepo>(
        data repoData: RepoState<Value>,
        fileKey: String
    ) {
        guard let key = cachedKey else { return }
        guard var url = url(forFileKey: fileKey) else { return }
        guard let value = repoData.value else {
            try? FileManager.default.removeItem(at: url)
            return
        }
        guard let clear = value.repoSerialise() else { return }
        guard let data = try? AES.GCM.seal(clear, using: key).combined else { return }
        try? data.write(to: url, options: .atomic)

        var values = URLResourceValues()
        values.isExcludedFromBackup = true
        try? url.setResourceValues(values)
    }

    static func resetKey() {
        RepoKey.reset()
        cachedKey = RepoKey.loadOrGenerate()
    }
}
