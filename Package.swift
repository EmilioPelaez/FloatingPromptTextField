// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FocusTextField",
    products: [
        .library(
            name: "FocusTextField",
            targets: ["FocusTextField"]),
    ],
    dependencies: [],
		targets: [
        .target(
            name: "FocusTextField",
            dependencies: []),
        .testTarget(
            name: "FocusTextFieldTests",
            dependencies: ["FocusTextField"]),
    ]
)
