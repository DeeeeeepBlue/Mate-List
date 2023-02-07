import ProjectDescription
import ProjectDescriptionHelpers


private let projectName = "Thirdparty"
private let iOSTargetVersion = "14.0"

let infoPlist: [String: InfoPlist.Value] = [
    "UILaunchScreen": [:]
]
let project = Project.framework(name: projectName,
                          platform: .iOS,
                        iOSTargetVersion: iOSTargetVersion,
                        packages: [
                            .firebase,
                            .googleSignIn,
                            .inject,
                            .rxSwift,
                            .rxViewController,
                            .rxGesture,
                            .snapKit,
                            .rxNimble,
                        ],
                          dependencies: [
                            .firebaseAuth,
                            .firebaseStorage,
                            .firebaseDatabase,
                            .firebaseAnalytics,
                            .firebaseFirestore,
                            .firebaseMessaging,
                            .firebaseCrashlytics,
                            .googleSignIn,
                            .rxSwift,
                            .rxGesture,
                            .rxViewController,
                            .rxCocoa,
                            .rxRelay,
                            .snapKit,
                            .inject,
                          ])

