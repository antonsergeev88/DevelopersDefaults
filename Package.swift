// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "DeveloperDefaults",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "DeveloperDefaults", targets: ["DeveloperDefaults"]),
        .library(name: "DeveloperDefaultsUI", targets: ["DeveloperDefaultsUI"])
    ],
    targets: [
        .target(name: "DeveloperDefaultsUI", dependencies: ["DeveloperDefaults"]),
        .target(name: "DeveloperDefaults", dependencies: ["DeveloperDefaultsRuntime"]),
        .target(name: "DeveloperDefaultsRuntime")
    ]
)
