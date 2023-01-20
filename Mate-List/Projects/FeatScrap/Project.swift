import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "FeatScrap",
    organizationName: "com.ognam",
    options: .options(automaticSchemesOptions: .enabled()),
    packages: [],
    targets: [
        Project.target(
            name: "FeatScrap",
            product: .app,
            sources: "Sources/**",
            resources: "Resources/**"
        )
    ]
)
