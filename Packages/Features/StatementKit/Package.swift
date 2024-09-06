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
    dependencies: [
        .package(path: "../ComponentsKit"),
        .package(path: "../DynamicKit"),
        .package(path: "../NetworkKit")
    ],
    targets: [
        .target(
            name: "StatementKit",
            dependencies: [
                "ComponentsKit",
                "DynamicKit",
                "NetworkKit"
            ],
            resources: [
                .process("Utils/Resources/Strings/"),
                .process("Utils/Resources/Images/")
            ]
        ),
        .testTarget(
            name: "StatementKitTests",
            dependencies: ["StatementKit"]
        )
    ]
)
