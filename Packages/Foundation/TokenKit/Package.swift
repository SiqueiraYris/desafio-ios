// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TokenKit",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "TokenKit",
            targets: ["TokenKit"]
        )
    ],
    dependencies: [
        .package(path: "../NetworkKit"),
    ],
    targets: [
        .target(
            name: "TokenKit",
            dependencies: [
                "NetworkKit"
            ]
        ),
        .testTarget(
            name: "TokenKitTests",
            dependencies: ["TokenKit"]
        )
    ]
)
