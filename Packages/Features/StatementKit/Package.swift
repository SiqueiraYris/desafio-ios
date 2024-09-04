// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StatementKit",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "StatementKit",
            targets: ["StatementKit"]
        )
    ],
    targets: [
        .target(
            name: "StatementKit"),
        .testTarget(
            name: "StatementKitTests",
            dependencies: ["StatementKit"]
        )
    ]
)
