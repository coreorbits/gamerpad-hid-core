// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "GamerpadHIDCore",
    platforms: [
        .macOS("15.0")
    ],
    products: [
        .library(
            name: "GamerpadHIDCore",
            targets: ["GamerpadHIDCore"]
        ),
    ],
    targets: [
        .target(
            name: "GamerpadHIDCore",
            path: "Sources/GamerpadHIDCore"
        ),
        .testTarget(
            name: "GamerpadHIDCoreTests",
            dependencies: ["GamerpadHIDCore"],
            path: "Tests/GamerpadHIDCoreTests"
        ),
    ]
)
