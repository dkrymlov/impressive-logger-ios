// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ImpressiveLogger",
    platforms: [.iOS(.v16), .macOS(.v13), .watchOS(.v9), .tvOS(.v16), .visionOS(.v1)],
    products: [
        .library(
            name: "ImpressiveLogger",
            targets: [
                "ImpressiveLogger"
            ]
        ),
    ],
    targets: [
        .target(
            name: "ImpressiveLogger",
            path: "Sources"
        ),
        .testTarget(
            name: "LoggerTests",
            dependencies: ["ImpressiveLogger"],
            path: "Tests"
        )
    ],
)
