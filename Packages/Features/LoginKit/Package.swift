// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LoginKit",
    defaultLocalization: LanguageTag(stringLiteral: "pt"),
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "LoginKit",
            targets: ["LoginKit"]
        )
    ],
    targets: [
        .target(
            name: "LoginKit"),
        .testTarget(
            name: "LoginKitTests",
            dependencies: ["LoginKit"]
        )
    ]
)
