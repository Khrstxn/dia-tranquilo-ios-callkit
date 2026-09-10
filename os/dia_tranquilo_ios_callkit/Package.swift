// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "dia_tranquilo_ios_callkit",

    platforms: [
        .iOS("13.4")
    ],

    products: [
        .library(
            name: "dia-tranquilo-ios-callkit",
            targets: ["dia_tranquilo_ios_callkit"]
        )
    ],

    dependencies: [
        .package(
            name: "FlutterFramework",
            path: "../FlutterFramework"
        )
    ],

    targets: [
        .target(
            name: "dia_tranquilo_ios_callkit",

            dependencies: [
                .product(
                    name: "FlutterFramework",
                    package: "FlutterFramework"
                )
            ],

            path: "Sources/dia_tranquilo_ios_callkit"
        )
    ]
)
