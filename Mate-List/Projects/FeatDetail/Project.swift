import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "FeatDetail",
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
            name: "FeatDetail",
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
