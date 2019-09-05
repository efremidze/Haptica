// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "Haptica",
    products: [
        .library(name: "Haptica",  targets: ["Haptica"])
    ],
    dependencies: [],
    targets: [
        .target(name: "Haptica", path: "Sources")
    ]
)
