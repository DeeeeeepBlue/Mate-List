import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "FeatDetail",
    organizationName: "com.ognam",
    options: .options(automaticSchemesOptions: .enabled()),
    packages: [],
    targets: [
        Project.target(
            name: "FeatDetail",
            product: .app,
            sources: "Sources/**",
            resources: "Resources/**"
        )
    ]
)
