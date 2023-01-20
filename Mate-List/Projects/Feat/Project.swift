import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Feat",
    organizationName: "com.ognam",
    options: .options(automaticSchemesOptions: .enabled()),
    packages: [],
    targets: [
        Project.target(
            name: "Feat",
            product: .app,
            sources: "Sources/**",
            resources: "Resources/**"
        )
    ]
)
