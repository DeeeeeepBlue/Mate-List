import ProjectDescription
import ProjectDescriptionHelpers

private let projectName = "Network"
private let iOSTargetVersion = "14.0"

let infoPlist: [String: InfoPlist.Value] = [
    "UILaunchScreen": [:]
]
let project = Project.framework(name: projectName,
                          platform: .iOS,
                          iOSTargetVersion: iOSTargetVersion,
                          dependencies: [
                            .external(name: "GoogleSignIn"),
                            .external(name: "RxSwift"),
                            .external(name: "FirebaseAuth"),
                            .external(name: "FirebaseFirestore"),
                            .external(name: "FirebaseDatabase"),
                            .external(name: "FirebaseStorage"),
                          ])

