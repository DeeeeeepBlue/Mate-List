import ProjectDescription
import ProjectDescriptionHelpers

private let projectName = "Utility"
private let iOSTargetVersion = "14.0"

let infoPlist: [String: InfoPlist.Value] = [
    "UILaunchScreen": [:]
]
let project = Project.framework(name: projectName,
                                platform: .iOS,
                                iOSTargetVersion: iOSTargetVersion,
                                packages: [],
                                dependencies: [
                                    .thirdparty
                                ])
