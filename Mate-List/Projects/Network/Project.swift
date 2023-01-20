import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Network",
    organizationName: "com.ognam",
    options: .options(automaticSchemesOptions: .enabled()),
    packages: [],
    targets: [
        Project.target(
            name: "Network",
            product: .app,
            sources: "Sources/**",
            resources: "Resources/**"
        )
    ]
)
