import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Network",
    organizationName: "com.ognam",
    options: .options(automaticSchemesOptions: .enabled()),
    packages: [
        .snapKit,
        .rxSwift,
        .rxGesture,
        .rxViewController,
        .firebase,
        .googleSignIn
    ],
    targets: [
        Project.target(
            name: "Network",
            product: .framework,
            sources: "Sources/**",
            resources: "Resources/**",
            dependencies: [
                .rxSwift,
                .googleSignIn,
                .firebaseAuth,
                .firebaseStorage,
                .firebaseDatabase,
                .firebaseFirestore
            ]
        )
    ]
)
