// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "Komondor",
    products: [
        .executable(name: "komondor", targets: ["Komondor"]),
    ],
    dependencies: [
        // User deps
        .package(url: "https://github.com/shibapm/PackageConfig.git", from: "0.13.0"),
        .package(url: "https://github.com/JohnSundell/ShellOut.git", from: "2.1.0"),
    ],
    targets: [
        .target(
            name: "Komondor",
            dependencies: ["PackageConfig", "ShellOut"]
        ),
        .testTarget(
            name: "KomondorTests",
            dependencies: ["Komondor"]
        ),
    ]
)

#if canImport(PackageConfig)
    import PackageConfig

    let config = PackageConfiguration([
        "komondor": [
            "pre-push": "swift test",
            "pre-commit": [
                "swift test",
                "swift run swiftformat .",
                "swift run swiftlint autocorrect --path Sources/",
                "git add .",
            ],
        ],
        "rocket": [
            "after": [
                "push",
            ],
        ],
    ]).write()
#endif
