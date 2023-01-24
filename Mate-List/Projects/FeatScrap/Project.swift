import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "FeatScrap",
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
            name: "FeatScrap",
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
            name: "FeatScrap",
            platform: .iOS
        )
    ]
)
