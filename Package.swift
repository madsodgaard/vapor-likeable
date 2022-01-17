// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "Likeable",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "Likeable",
            targets: ["Likeable"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/fluent.git", from: "4.4.0"),
    ],
    targets: [
        .target(
            name: "Likeable",
            dependencies: [
                .product(name: "Fluent", package: "fluent"),
            ]
        ),
        .testTarget(
            name: "LikeableTests",
            dependencies: ["Likeable"]
        ),
    ]
)
