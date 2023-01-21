import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "FeatNickName",
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
            name: "FeatNickName",
            product: .app,
            sources: "Sources/**",
            resources: "Resources/**",
            dependencies: [
                .snapKit,
                .rxSwift,
                .rxGesture,
                .rxViewController,
                .rxCocoa,
                .rxRelay
            ]
        )
    ]
)
