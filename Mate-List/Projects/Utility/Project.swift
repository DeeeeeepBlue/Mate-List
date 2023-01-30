import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Utility",
    organizationName: "com.ognam",
    options: .options(automaticSchemesOptions: .enabled()),
    packages: [
        .firebase,
        .googleSignIn
    ],
    targets: [
        Project.target(
            name: "Utility",
            product: .framework,
            sources: "Sources/**",
            resources: "Resources/**",
            dependencies: [
                .firebaseAuth,
                .firebaseFirestore,
                .googleSignIn,
                .snapKit
            ]
        )
//        ,
//        Project.testTarget(
//            name: "Utility",
//            platform: .iOS
//        )
    ]
)
