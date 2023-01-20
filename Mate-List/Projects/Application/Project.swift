import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Application",
    organizationName: "com.ognam",
    options: .options(automaticSchemesOptions: .enabled()),
    packages: [],
    targets: [
        Project.target(
            name: "Application",
            product: .app,
            sources: "Sources/**",
            resources: "Resources/**"
        )
    ]
)
