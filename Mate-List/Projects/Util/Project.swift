import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Util",
    organizationName: "com.ognam",
    options: .options(automaticSchemesOptions: .enabled()),
    packages: [
        .firebase,
        .googleSignIn
    ],
    targets: [
        Project.target(
            name: "Util",
            product: .app,
            sources: "Sources/**",
            resources: "Resources/**",
            dependencies: [
                .firebaseAuth,
                .googleSignIn
            ]
        )
    ]
)
