import ProjectDescription
import ProjectDescriptionHelpers

private let projectName = "FeatDetail"
private let iOSTargetVersion = "14.0"

let infoPlist: [String: InfoPlist.Value] = [
    "UILaunchScreen": [:]
]

let project = Project.frameworkWithDemoApp(
                          name: projectName,
                          platform: .iOS,
                          iOSTargetVersion: iOSTargetVersion,
                          infoPlist: infoPlist,
                          dependencies: [
                            .external(name: "SnapKit"),
                            .external(name: "RxSwift"),
                            .external(name: "RxCocoa"),
                            .external(name: "RxGesture"),
                            .external(name: "RxViewController"),
                            .core
                          ])
