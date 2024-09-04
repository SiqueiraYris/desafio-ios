// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RouterKit",
    defaultLocalization: LanguageTag(stringLiteral: "pt"),
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "RouterKit",
            targets: ["RouterKit"]
        )
    ],
    targets: [
        .target(
            name: "RouterKit"),
        .testTarget(
            name: "RouterKitTests",
            dependencies: ["RouterKit"]
        )
    ]
)
