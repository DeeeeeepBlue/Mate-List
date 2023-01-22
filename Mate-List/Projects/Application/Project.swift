import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Application",
    organizationName: "com.ognam",
    options: .options(automaticSchemesOptions: .enabled()),
    packages: [
        .rxSwift,
        .googleSignIn,
        .firebase
    ],
    targets: [
        Project.target(
            name: "Application",
            product: .app,
            sources: "Sources/**",
            resources: "Resources/**",
            dependencies: [
                .rxSwift,
                .googleSignIn,
                .firebaseAuth,
                .firebaseFirestore,
                .feat
            ]
        )
    ]
)
