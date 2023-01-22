import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Feat",
    organizationName: "com.ognam",
    options: .options(automaticSchemesOptions: .enabled()),
    packages: [
        
    ],
    targets: [
        Project.target(
            name: "Feat",
            product: .framework,
            sources: "Sources/**",
            resources: "Resources/**",
            dependencies: [
                .featHome,
                .featScrap,
                .featDetail,
                .featSetting,
                .featNickName,
                .featSurvey
            ]
        )
    ]
)
