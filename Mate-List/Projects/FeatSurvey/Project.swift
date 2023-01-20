import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "FeatSurvey",
    organizationName: "com.ognam",
    options: .options(automaticSchemesOptions: .enabled()),
    packages: [],
    targets: [
        Project.target(
            name: "FeatSurvey",
            product: .app,
            sources: "Sources/**",
            resources: "Resources/**"
        )
    ]
)
