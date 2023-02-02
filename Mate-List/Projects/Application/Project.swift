import ProjectDescription
import ProjectDescriptionHelpers

private let projectName = "Application"
private let iOSTargetVersion = "14.0"

let infoPlistPath: String = "Resources/Application-Info.plist"

let project = Project.app(name: projectName,
                          platform: .iOS,
                          iOSTargetVersion: iOSTargetVersion,
                          infoPlist: infoPlistPath,
                          dependencies: [
                            .external(name: "SnapKit"),
                            .external(name: "RxSwift"),
                            .external(name: "GoogleSignIn"),
                            .external(name: "FirebaseAuth"),
                            .external(name: "FirebaseFirestore"),
                            .feat
                          ])
