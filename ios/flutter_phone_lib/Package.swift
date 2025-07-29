// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "flutter_phone_lib",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "flutter-phone-lib",
            targets: ["flutter_phone_lib"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/open-voip-alliance/iOS-Phone-Lib.git", exact: "0.1.15"),
    ],
    targets: [
        .target(
            name: "flutter_phone_lib",
            dependencies: [
                .product(name: "iOSPhoneLib", package: "ios-phone-lib")
            ]
        )
    ]
)
