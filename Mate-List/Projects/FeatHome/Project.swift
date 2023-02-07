import ProjectDescription
import ProjectDescriptionHelpers

private let projectName = "FeatHome"
private let iOSTargetVersion = "14.0"

let infoPlist: [String: InfoPlist.Value] = [
    "UILaunchScreen": [:]
]

let project = Project.frameworkWithDemoApp(name: projectName,
                                           platform: .iOS,
                                           iOSTargetVersion: iOSTargetVersion,
                                           infoPlist: infoPlist,
                                           packages: [],
                                           dependencies: [
                                            .thirdparty,
                                            .core,
                                            .featDetail
                                           ])
