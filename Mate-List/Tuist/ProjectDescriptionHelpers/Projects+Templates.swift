import ProjectDescription

/// Project helpers are functions that simplify the way you define your project.
/// Share code to create targets, settings, dependencies,
/// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
/// See https://docs.tuist.io/guides/helpers/


extension Project {
    private static let organizationName = "com.ognam"
    
    public static func app(name: String,
                           platform: Platform,
                           iOSTargetVersion: String,
                           infoPlist: String,
                           dependencies: [TargetDependency] = []) -> Project {
        let targets = makeAppTargets(name: name,
                                     platform: platform,
                                     iOSTargetVersion: iOSTargetVersion,
                                     infoPlist: infoPlist,
                                     dependencies: dependencies)
        return Project(name: name,
                       organizationName: organizationName,
                       targets: targets)
    }

    public static func frameworkWithDemoApp(name: String,
                                            platform: Platform,
                                            iOSTargetVersion: String,
                                            infoPlist: [String: InfoPlist.Value] = [:],
                                            dependencies: [TargetDependency] = []) -> Project {
        var targets = makeFrameworkTargets(name: name,
                                           platform: platform,
                                           iOSTargetVersion: iOSTargetVersion,
                                           dependencies: dependencies)
        targets.append(contentsOf: makeAppTargets(name: "\(name)DemoApp",
                                                  platform: platform,
                                                  iOSTargetVersion: iOSTargetVersion,
                                                  infoPlist: infoPlist,
                                                  dependencies: [.target(name: name)]))

        return Project(name: name,
                       organizationName: organizationName,
                       targets: targets)
    }

    public static func framework(name: String,
                                 platform: Platform, iOSTargetVersion: String,
                                 dependencies: [TargetDependency] = []) -> Project {
        let targets = makeFrameworkTargets(name: name,
                                           platform: platform,
                                           iOSTargetVersion: iOSTargetVersion,
                                           dependencies: dependencies)
        return Project(name: name,
                       organizationName: organizationName,
                       targets: targets)
    }
}

private extension Project {

    static func makeFrameworkTargets(name: String, platform: Platform, iOSTargetVersion: String, dependencies: [TargetDependency] = []) -> [Target] {
        let sources = Target(name: name,
                             platform: platform,
                             product: .framework,
                             bundleId: "team.io.\(name)",
                             deploymentTarget: .iOS(targetVersion: iOSTargetVersion, devices: [.iphone]),
                             infoPlist: .default,
                             sources: ["Sources/**"],
                             resources: ["Resources/**"],
                             dependencies: dependencies)
        let tests = Target(name: "\(name)Tests",
                           platform: platform,
                           product: .unitTests,
                           bundleId: "team.io.\(name)Tests",
                           infoPlist: .default,
                           sources: ["Tests/**"],
                           resources: [],
                           dependencies: [
                            .target(name: name),
                            .external(name: "RxTest"),
                            .external(name: "RxNimble")
                           ])
        return [sources, tests]
    }

    static func makeAppTargets(name: String, platform: Platform, iOSTargetVersion: String, infoPlist: [String: InfoPlist.Value] = [:], dependencies: [TargetDependency] = []) -> [Target] {
        let platform: Platform = platform

        let mainTarget = Target(
            name: name,
            platform: platform,
            product: .app,
            bundleId: "team.io.\(name)",
            deploymentTarget: .iOS(targetVersion: iOSTargetVersion, devices: [.iphone]),
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: dependencies
        )

        let testTarget = Target(
            name: "\(name)Tests",
            platform: platform,
            product: .unitTests,
            bundleId: "team.io.Tests",
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "\(name)"),
                .external(name: "RxTest"),
                .external(name: "RxNimble")
            ])
        return [mainTarget, testTarget]
    }

    static func makeAppTargets(name: String, platform: Platform, iOSTargetVersion: String, infoPlist: String, dependencies: [TargetDependency] = []) -> [Target] {
        let platform: Platform = platform

        let mainTarget = Target(
            name: name,
            platform: platform,
            product: .app,
            bundleId: "team.io.\(name)",
            deploymentTarget: .iOS(targetVersion: iOSTargetVersion, devices: [.iphone]),
            infoPlist: InfoPlist(stringLiteral: infoPlist),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: dependencies
        )

        let testTarget = Target(
            name: "\(name)Tests",
            platform: platform,
            product: .unitTests,
            bundleId: "team.io.Tests",
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "\(name)"),
                .external(name: "RxTest"),
                .external(name: "RxNimble")
            ])
        return [mainTarget, testTarget]
    }
}

// MARK: Project
public extension TargetDependency {
    static let core: TargetDependency = .project(target: "Core",
                                                 path: .relativeToRoot("Projects/Core"))
    static let feat: TargetDependency = .project(target: "Feat",
                                                              path: .relativeToRoot("Projects/Feat"))
    static let featDetail: TargetDependency = .project(target: "FeatDetail",
                                                              path: .relativeToRoot("Projects/FeatDetail"))
    static let featHome: TargetDependency = .project(target: "FeatHome",
                                                              path: .relativeToRoot("Projects/FeatHome"))
    static let featNickName: TargetDependency = .project(target: "FeatNickName",
                                                              path: .relativeToRoot("Projects/FeatNickName"))
    static let featScrap: TargetDependency = .project(target: "FeatScrap",
                                                              path: .relativeToRoot("Projects/FeatScrap"))
    static let featSetting: TargetDependency = .project(target: "FeatSetting",
                                                              path: .relativeToRoot("Projects/FeatSetting"))
    static let featSurvey: TargetDependency = .project(target: "FeatSurvey",
                                                              path: .relativeToRoot("Projects/FeatSurvey"))
    static let network: TargetDependency = .project(target: "Network",
                                                              path: .relativeToRoot("Projects/Network"))
    static let utility: TargetDependency = .project(target: "Utility",
                                                              path: .relativeToRoot("Projects/Utility"))
}

//// MARK: Package
//public extension TargetDependency {
//    static let firebaseAnalytics: TargetDependency = .package(product: "FirebaseAnalytics")
//    static let firebaseAuth: TargetDependency =
//        .package(product: "FirebaseAuth")
//    static let firebaseDatabase: TargetDependency =
//        .package(product: "FirebaseDatabase")
//    static let firebaseFirestore: TargetDependency =
//        .package(product: "FirebaseFirestore")
//    static let firebaseStorage: TargetDependency =
//        .package(product: "FirebaseStorage")
//    static let firebaseMessaging: TargetDependency = .package(product: "FirebaseMessaging")
//    static let firebaseCrashlytics: TargetDependency = .package(product: "FirebaseCrashlytics")
//
//    static let rxSwift: TargetDependency = .package(product: "RxSwift")
//    static let rxCocoa: TargetDependency = .package(product: "RxCocoa")
//    static let rxGesture: TargetDependency = .package(product: "RxGesture")
//    static let rxRelay: TargetDependency = .package(product: "RxRelay")
//    static let rxViewController: TargetDependency = .package(product: "RxViewController")
//
//    static let snapKit: TargetDependency = .package(product: "SnapKit")
//    static let flexLayout: TargetDependency = .package(product: "Flex")
//    static let googleSignIn: TargetDependency = .package(product: "GoogleSignIn")
//    static let inject: TargetDependency = .package(product: "Inject")
//
//    static let rxNimble: TargetDependency = .package(product: "RxNimble")
//}
//
//public extension Package {
//    static let firebase: Package = .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "8.0.0")
//
//    static let rxSwift: Package = .package(url: "https://github.com/ReactiveX/RxSwift.git", .branch("main"))
//    static let rxGesture: Package = .package(url: "https://github.com/RxSwiftCommunity/RxGesture.git",
//                                             .branch("main"))
//    static let rxViewController: Package = .package(url: "https://github.com/devxoul/RxViewController.git", .exact("2.0.0"))
//    static let rxNimble: Package = .package(url: "https://github.com/RxSwiftCommunity/RxNimble.git", .branch("master"))
//
//    static let googleSignIn: Package = .package(url: "https://github.com/google/GoogleSignIn-iOS.git", .branch("main"))
//    static let inject: Package = .package(url: "https://github.com/krzysztofzablocki/Inject.git", .exact("1.2.2"))
//    static let snapKit: Package = .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1"))
//
//
//}
