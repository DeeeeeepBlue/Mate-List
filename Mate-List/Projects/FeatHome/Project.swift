import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "FeatHome",
    organizationName: "com.ognam",
    options: .options(automaticSchemesOptions: .enabled()),
    packages: [],
    targets: [
        Project.target(
            name: "FeatHome",
            product: .app,
            sources: "Sources/**",
            resources: "Resources/**"
        )
    ]
)
