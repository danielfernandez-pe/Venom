// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Venom",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "Venom",
            targets: ["Venom"]
        ),
    ],
    targets: [
        .target(
            name: "Venom",
            path: "Sources",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency"),
                .enableUpcomingFeature("InferIsolatedConformances"),
                .enableUpcomingFeature("NonisolatedNonsendingByDefault")
            ]
        ),
        .testTarget(
            name: "VenomTests",
            dependencies: ["Venom"]
        ),
    ]
)
