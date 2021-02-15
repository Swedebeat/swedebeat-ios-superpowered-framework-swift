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
        .target(
            name: "SuperpoweredSwift",
            dependencies: []
        ),
        .testTarget(
            name: "SuperpoweredSwiftTests",
            dependencies: ["SuperpoweredSwift"]
        )
    ]
)
