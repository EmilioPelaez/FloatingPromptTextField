// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "FloatingPromptTextField",
	platforms: [.iOS(.v15)],
	products: [
		.library(
			name: "FloatingPromptTextField",
			targets: ["FloatingPromptTextField"]
		),
	],
	dependencies: [],
	targets: [
		.target(
			name: "FloatingPromptTextField",
			dependencies: []
		),
	]
)
