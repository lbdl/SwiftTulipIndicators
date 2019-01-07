// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftTulipIndicators",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "SwiftTulipIndicators",
            targets: ["SwiftTulipIndicators"]),
    ],
    dependencies: [
        .package(url: "https://github.com/lbdl/CTulipIndicatorsPackage.git", from: "0.0.2"),
        .package(url: "https://github.com/Quick/Quick.git", .from("1.3.2")),
        .package(url: "https://github.com/Quick/Nimble.git", .from("7.3.1")),
        ],
    targets: [
        .target(
            name: "SwiftTulipIndicators",
            dependencies: ["CTulipIndicators"]),
        .testTarget(
            name: "SwiftTulipIndicatorsTests",
            dependencies: ["SwiftTulipIndicators", "Quick", "Nimble"]),
    ]
)
