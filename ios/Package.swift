// ios/Package.swift
import PackageDescription

let package = Package(
    name: "my_awesome_plugin",
    platforms: [
        .iOS(.v9)  // Match your podspec minimum version
    ],
    products: [
        .library(
            name: "MyAwesomePlugin",
            targets: ["MyAwesomePlugin"]
        )
    ],
    dependencies: [
        // Add any Swift dependencies you need here
        // Example dependencies for your plugin's functionality:
        // .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.0.0"),
        // .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", from: "5.0.0")
    ],
    targets: [
        .target(
            name: "MyAwesomePlugin",
            dependencies: [
                // Add dependency targets here
                // "Alamofire",
                // "SwiftyJSON"
            ],
            path: "Classes",
            publicHeadersPath: ".",
            cSettings: [
                .headerSearchPath(".")
            ]
        )
    ]
)