// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LauncherKit",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "LauncherKit",
            targets: ["LauncherKit"]
        )
    ],
    dependencies: [
        .package(path: "../RouterKit"),
        .package(path: "../ComponentsKit")
    ],
    targets: [
        .target(
            name: "LauncherKit",
            dependencies: [
                "RouterKit",
                "ComponentsKit"
            ],
            resources: [
                .process("Utils/Resources/Strings/"),
                .process("Utils/Resources/Images/")
            ]
        ),
        .testTarget(
            name: "LauncherKitTests",
            dependencies: ["LauncherKit", "RouterKit", "ComponentsKit"]
        )
    ]
)
