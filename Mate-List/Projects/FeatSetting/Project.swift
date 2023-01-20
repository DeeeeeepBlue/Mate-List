import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "FeatSetting",
    organizationName: "com.ognam",
    options: .options(automaticSchemesOptions: .enabled()),
    packages: [],
    targets: [
        Project.target(
            name: "FeatSetting",
            product: .app,
            sources: "Sources/**",
            resources: "Resources/**"
        )
    ]
)
