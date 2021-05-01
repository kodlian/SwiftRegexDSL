// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftRegexDSL",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "SwiftRegexDSL",
            targets: ["SwiftRegexDSL"]),
    ],
    targets: [
        .target(
            name: "SwiftRegexDSL",
            dependencies: []),
        .testTarget(
            name: "SwiftRegexDSLTests",
            dependencies: ["SwiftRegexDSL"]),
    ]
)
