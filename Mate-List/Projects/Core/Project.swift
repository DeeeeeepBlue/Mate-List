import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Core",
    organizationName: "com.ognam",
    options: .options(automaticSchemesOptions: .enabled()),
    packages: [],
    targets: [
        Project.target(
            name: "Core",
            product: .app,
            sources: "Sources/**",
            resources: "Resources/**"
        )
    ]
)
