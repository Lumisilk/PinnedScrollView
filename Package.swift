// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PinnedScrollView",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "PinnedScrollView",
            targets: ["PinnedScrollView"]
        ),
    ],
    targets: [
        .target(name: "PinnedScrollView")
    ]
)
