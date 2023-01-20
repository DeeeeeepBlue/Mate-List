import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "FeatNickName",
    organizationName: "com.ognam",
    options: .options(automaticSchemesOptions: .enabled()),
    packages: [],
    targets: [
        Project.target(
            name: "FeatNickName",
            product: .app,
            sources: "Sources/**",
            resources: "Resources/**"
        )
    ]
)
