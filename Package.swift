// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SamplePackageB",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SamplePackageB",
            targets: ["SamplePackageB"]
        ),
        .library(
            name: "3rdPartyResources",
            targets: ["3rdPartyResources"]
        ),
        .library(
            name: "3rdPartyAdapter",
            targets: ["3rdPartyAdapter"]
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SamplePackageB"),
        .target(
            name: "3rdPartyAdapter",
            dependencies: [
                "SamplePackageB",
                "3rdPartyResources"
            ],
            linkerSettings: [
                .linkedFramework("AuthenticationServices"),
                .linkedFramework("CoreLocation"),
                .linkedFramework("LocalAuthentication")
            ]
        ),
        .target(
            name: "3rdPartyResources",
            dependencies: [
                .target(
                    name: "OneSignal",
                    condition: .when(platforms: [.iOS])
                ),
                .target(
                    name: "OneSignalCore",
                    condition: .when(platforms: [.iOS])
                ),
                .target(
                    name: "OneSignalExtension",
                    condition: .when(platforms: [.iOS])
                )
            ],
            resources: [
                .copy("Resources/3pa.sdk.bundle"),
            ]
        ),
        .binaryTarget(
            name: "OneSignal",
            path: "Frameworks/OneSignal.xcframework"
        ),
        .binaryTarget(
            name: "OneSignalCore",
            path: "Frameworks/OneSignalCore.xcframework"
        ),
        .binaryTarget(
            name: "OneSignalExtension",
            path: "Frameworks/OneSignalExtension.xcframework"
        ),
        .binaryTarget(
            name: "OneSignalOutcomes",
            path: "Frameworks/OneSignalOutcomes.xcframework"
        ),
        .testTarget(
            name: "SamplePackageBTests",
            dependencies: ["SamplePackageB"]),
    ]
)
