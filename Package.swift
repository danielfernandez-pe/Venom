// swift-tools-version: 6.0
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
    dependencies: [
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.8.3")
    ],
    targets: [
        .target(
            name: "Venom",
            dependencies: ["Swinject"],
            path: "Sources"
        ),
        .testTarget(
            name: "VenomTests",
            dependencies: ["Venom"]
        ),
    ]
)
