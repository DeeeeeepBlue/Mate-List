import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "FeatSetting",
    organizationName: "com.ognam",
    options: .options(automaticSchemesOptions: .enabled()),
    packages: [
        .snapKit,
        .rxSwift,
        .rxGesture,
        .rxViewController
    ],
    targets: [
        Project.target(
            name: "FeatSetting",
            product: .framework,
            sources: "Sources/**",
            resources: "Resources/**",
            dependencies: [
                .snapKit,
                .rxSwift,
                .rxGesture,
                .rxViewController,
                .rxCocoa,
                .rxRelay,
                .core
            ]
        ),
        Project.testTarget(
            name: "FeatSetting",
            platform: .iOS
        )
    ]
)
