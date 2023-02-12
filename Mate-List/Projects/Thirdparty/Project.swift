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
                            .firebaseFirestore,
                            .firebaseMessaging,
                            // TODO: 릴리즈 후 사용
                            //.firebaseCrashlytics,
                            //.firebaseAnalytics,
                            .googleSignIn,
                            .rxSwift,
                            .rxGesture,
                            .rxViewController,
                            .rxCocoa,
                            .rxRelay,
                            .snapKit,
                            .inject,
                          ])

