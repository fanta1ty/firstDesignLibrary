// swift-tools-version: 6.0
// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "firstDesignLibrary",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "firstDesignLibrary",
            targets: ["firstDesignLibrary"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "firstDesignLibrary",
            path: "Sources"
        ),
    ]
)
