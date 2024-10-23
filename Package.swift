#if compiler(>=5.8)
// Code for Swift 5.8 or newer
// swift-tools-version: 6.0
#else
// Code for Swift 5.7 or older
// swift-tools-version: 5.7
#endif

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
            path: "Sources"
        ),
    ]
)
