// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SuperpoweredSwift",
    products: [
        .library(
            name: "SuperpoweredSwift",
            targets: ["SuperpoweredSwift"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "SuperpoweredFramework",
            path: "SuperpoweredFramework.xcframework"
        ),
        .target(
            name: "SuperpoweredSwift",
            dependencies: ["SuperpoweredFramework"]
        ),
        .testTarget(
            name: "SuperpoweredSwiftTests",
            dependencies: ["SuperpoweredSwift"]
        )
    ]
)
