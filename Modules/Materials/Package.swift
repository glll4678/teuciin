// swift-tools-version: 5.9

import PackageDescription

let package = Package(
        name: "Materials",
        platforms: [.iOS(.v15)],
        products: [
                .library(
                        name: "Materials",
                        targets: ["Materials"]
                )
        ],
        targets: [
                .target(
                        name: "Materials",
                        resources: [.process("Resources")]
                ),
                .testTarget(
                        name: "MaterialsTests",
                        dependencies: ["Materials"]
                )
        ]
)
