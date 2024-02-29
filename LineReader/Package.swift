// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LineReader",
    products: [
        .library(
            name: "LineReader",
            targets: ["LineReader"]),
        .library(
            name: "CharBuffer",
            targets: ["CharBuffer"]
        )
    ],
    targets: [
        .target(
            name: "LineReader",
            dependencies: [
                "CharBuffer"
            ]
        ),
        .target(
            name: "CharBuffer"),
        .testTarget(
            name: "LineReaderTests",
            dependencies: [
                "LineReader",
                "CharBuffer"
            ]
        ),
    ]
)
