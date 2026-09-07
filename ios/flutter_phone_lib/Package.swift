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
        .package(url: "https://github.com/JohannesNevels/Swinject.git", exact: "2.9.2"),
        .package(url: "https://gitlab.linphone.org/BC/public/linphone-sdk-swift-ios.git", exact: "5.4.24"),
    ],
    targets: [
        .target(
            name: "flutter_phone_lib",
            dependencies: [
                "iOSPhoneLib"
            ]
        ),
        // Vendored from open-voip-alliance/iOS-Phone-Lib (0.1.18).
        .target(
            name: "iOSPhoneLib",
            dependencies: [
                .product(name: "Swinject", package: "Swinject"),
                "LinphoneWrapper"
            ],
            path: "iOSPhoneLib",
            resources: [
                .process("iOSVoIPLib/Resources/ringback.wav"),
                .process("PIL/Localizable.stringsdict"),
            ]
        ),
        .target(
            name: "LinphoneWrapper",
            dependencies: [
                .product(name: "linphonesw", package: "linphone-sdk-swift-ios")
            ],
            path: "LinphoneWrapper/Sources"
        ),
    ]
)
