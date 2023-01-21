import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "FeatSurvey",
    organizationName: "com.ognam",
    options: .options(automaticSchemesOptions: .enabled()),
    packages: [
        .snapKit,
        .rxSwift,
        .rxGesture,
        .rxViewController,
        .inject
    ],
    targets: [
        Project.target(
            name: "FeatSurvey",
            product: .app,
            sources: "Sources/**",
            resources: "Resources/**",
            dependencies: [
                .snapKit,
                .rxSwift,
                .rxGesture,
                .rxViewController,
                .rxCocoa,
                .rxRelay,
                .inject
            ]
        )
    ]
)
