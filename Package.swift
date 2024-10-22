// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

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
            dependencies: [],
            path: "Sources"
        ),
    ]
)
