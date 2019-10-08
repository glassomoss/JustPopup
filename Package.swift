// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "JustPopup",
    platforms: [.iOS("13.0")],
    products: [
        .library(
            name: "JustPopup",
            targets: ["JustPopup"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "JustPopup",
            path: "JustPopup")
    ]
)
