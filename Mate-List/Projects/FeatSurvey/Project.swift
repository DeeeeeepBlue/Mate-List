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
                .inject,
                .core
            ]
        )
//        ,
//        Project.testTarget(
//            name: "FeatSurvey",
//            platform: .iOS
//        )
    ]
)
