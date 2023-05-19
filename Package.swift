// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PythonRuntime",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "PythonRuntime",
            targets: [
                "PythonRuntime"
            ]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/pvieito/PythonKit.git",
            from: .init(0, 3, 1)
        )
    ],
    targets: [
        .target(
            name: "PythonRuntime",
            dependencies: [
                "Python",
                "PythonKit"
            ]
        ),
        .binaryTarget(
            name: "Python",
            url: "https://github.com/alekseimuraveinik/PythonRuntime/releases/download/Python.xcframework/Python.xcframework.zip",
            checksum: "956fac66d324cdd6624c6133a46786e114743bbaa6a37f6afb274d0aaf80bda3"
        )
    ]
)
