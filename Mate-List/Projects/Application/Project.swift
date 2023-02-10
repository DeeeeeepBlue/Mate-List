import ProjectDescription
import ProjectDescriptionHelpers

private let projectName = "Mate-List"
private let iOSTargetVersion = "14.0"

let infoPlistPath: String = "Resources/Application-Info.plist"

let infoPlist: [String: InfoPlist.Value] = [
    "CFBundleShortVersionString": "1.0",
    "CFBundleVersion": "1",
    "UILaunchStoryboardName": "LaunchScreen",
    "NSAppTransportSecurity" : ["NSAllowsArbitraryLoads":true],
    "UISupportedInterfaceOrientations" : ["UIInterfaceOrientationPortrait"],
    "UIUserInterfaceStyle":"Light",
    "UIApplicationSceneManifest" : ["UIApplicationSupportsMultipleScenes":true,
                                    "UISceneConfigurations":[
                                        "UIWindowSceneSessionRoleApplication":[[
                                            "UISceneConfigurationName":"Default Configuration",
                                            "UISceneDelegateClassName":"$(PRODUCT_MODULE_NAME).SceneDelegate"
                                        ]]
                                    ]
                                   ]
    ]

let project = Project.app(name: projectName,
                          platform: .iOS,
                          iOSTargetVersion: iOSTargetVersion,
                          infoPlist: infoPlist,
                          packages: [],
                          dependencies: [
                            .feat
                          ])
