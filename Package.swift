// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FloatingPromptTextField",
    products: [
        .library(
            name: "FloatingPromptTextField",
            targets: ["FloatingPromptTextField"]),
    ],
    dependencies: [],
		targets: [
        .target(
            name: "FloatingPromptTextField",
            dependencies: []),
        .testTarget(
            name: "FloatingPromptTextFieldTests",
            dependencies: ["FloatingPromptTextField"]),
    ]
)
