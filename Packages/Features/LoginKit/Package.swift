// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LoginKit",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "LoginKit",
            targets: ["LoginKit"]
        )
    ],
    dependencies: [
        .package(path: "../RouterKit"),
        .package(path: "../ComponentsKit"),
        .package(path: "../DynamicKit"),
        .package(path: "../NetworkKit")
    ],
    targets: [
        .target(
            name: "LoginKit",
            dependencies: [
                "RouterKit",
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
            name: "LoginKitTests",
            dependencies: ["LoginKit"]
        )
    ]
)
