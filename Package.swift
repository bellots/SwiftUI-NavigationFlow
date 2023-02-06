// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SwiftUINavigationFlow",
    platforms: [
            .iOS("14.0"),
    ],
    products: [
            .library(
            name: "SwiftUINavigationFlow",
            targets: ["SwiftUINavigationFlow"]
        ),
    ],
    dependencies: [],
    targets: [
            .target(
            name: "SwiftUINavigationFlow",
            dependencies: [],
            path: "SwiftUINavigationFlow"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
