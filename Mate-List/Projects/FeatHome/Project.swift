import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "FeatHome",
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
            name: "FeatHome",
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
                .core,
                .featSurvey,
                .featDetail
            ]
        ),
        Project.testTarget(
            name: "FeatHome",
            platform: .iOS
        )
    ]
)
