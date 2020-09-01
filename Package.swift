// swift-tools-version:5.2

/**
*  KaTeXPublishPlugin
*  Copyright (c) Utku Birkan 2020
*  MIT license, see LICENSE file for details
*/

import PackageDescription

let package = Package(
    name: "KatexPublishPlugin",
    platforms: [.macOS(.v10_11)],
    products: [
        .library(
            name: "KatexPublishPlugin",
            targets: ["KatexPlugin", "KatexFoundationTheme"]),
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/kurabirko/publish.git", .branch("master")),
        .package(name: "Ink", url: "https://github.com/kurabirko/ink.git", .branch("math")),
        .package(name: "Plot", url: "https://github.com/johnsundell/plot.git", from: "0.1.0")
    ],
    targets: [
        .target(
            name: "KatexPlugin",
            dependencies: ["Publish", "Ink"]),
        .target(
            name: "KatexFoundationTheme",
            dependencies: ["Plot", "Publish"]),
        .testTarget(
            name: "KatexPluginTests",
            dependencies: ["KatexPlugin"]),
    ]
)
