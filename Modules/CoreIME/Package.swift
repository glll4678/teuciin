// swift-tools-version: 5.9

import PackageDescription

let package = Package(
        name: "CoreIME",
        platforms: [.iOS(.v15)],
        products: [
                .library(
                        name: "CoreIME",
                        targets: ["CoreIME"]
                )
        ],
        targets: [
                .target(
                        name: "CoreIME",
                        resources: [.process("Resources")]
                ),
                .testTarget(
                        name: "CoreIMETests",
                        dependencies: ["CoreIME"]
                )
        ]
)
