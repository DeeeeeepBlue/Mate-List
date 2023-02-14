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
                           infoPlist: [String: InfoPlist.Value],
                           packages: [Package],
                           dependencies: [TargetDependency] = []) -> Project {
        
        let targets = makeAppTargets(name: name,
                                     platform: platform,
                                     iOSTargetVersion: iOSTargetVersion,
                                     infoPlist: infoPlist,
                                     dependencies: dependencies)
        
        return Project(name: name,
                       organizationName: organizationName,
                       packages: packages,
                       targets: targets)
    }

    public static func frameworkWithDemoApp(name: String,
                                            platform: Platform,
                                            iOSTargetVersion: String,
                                            infoPlist: [String: InfoPlist.Value] = [:],
                                            packages: [Package],
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
                       packages: packages,
                       targets: targets)
    }

    public static func framework(name: String,
                                 platform: Platform,
                                 iOSTargetVersion: String,
                                 packages: [Package],
                                 dependencies: [TargetDependency] = []) -> Project {
        
        let targets = makeFrameworkTargets(name: name,
                                           platform: platform,
                                           iOSTargetVersion: iOSTargetVersion,
                                           dependencies: dependencies)
        
        return Project(name: name,
                       organizationName: organizationName,
                       packages: packages,
                       targets: targets)
    }
}

private extension Project {

    static func makeFrameworkTargets(name: String, platform: Platform, iOSTargetVersion: String, dependencies: [TargetDependency] = []) -> [Target] {
        let sources = Target(name: name,
                             platform: platform,
                             product: .framework,
                             bundleId: "\(organizationName).\(name)",
                             deploymentTarget: .iOS(targetVersion: iOSTargetVersion, devices: [.iphone]),
                             infoPlist: .default,
                             sources: ["Sources/**"],
                             resources: ["Resources/**"],
                             dependencies: dependencies)
//        let tests = Target(name: "\(name)Tests",
//                           platform: platform,
//                           product: .unitTests,
//                           bundleId: "\(organizationName).\(name)Tests",
//                           infoPlist: .default,
//                           sources: ["Tests/**"],
//                           resources: [],
//                           dependencies: [
//                            .target(name: name),
//                            .rxNimble,
//                            .rxTest
//                           ])
//        return [sources, tests]
        return [sources]
    }

    static func makeAppTargets(name: String, platform: Platform, iOSTargetVersion: String, infoPlist: [String: InfoPlist.Value] = [:], dependencies: [TargetDependency] = []) -> [Target] {
        let platform: Platform = platform

        let mainTarget = Target(
            name: name,
            platform: platform,
            product: .app,
            bundleId: "\(organizationName).\(name)",
            deploymentTarget: .iOS(targetVersion: iOSTargetVersion, devices: [.iphone]),
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: dependencies
        )

//        let testTarget = Target(
//            name: "\(name)Tests",
//            platform: platform,
//            product: .unitTests,
//            bundleId: "\(organizationName).Tests",
//            infoPlist: .default,
//            sources: ["Tests/**"],
//            dependencies: [
//                .target(name: "\(name)"),
//                .rxTest,
//                .rxNimble
//            ])
//        return [mainTarget, testTarget]
        return [mainTarget]
    }

    static func makeAppTargets(name: String, platform: Platform, iOSTargetVersion: String, infoPlist: String, dependencies: [TargetDependency] = []) -> [Target] {
        let platform: Platform = platform

        let mainTarget = Target(
            name: name,
            platform: platform,
            product: .app,
            bundleId: "\(organizationName).\(name)",
            deploymentTarget: .iOS(targetVersion: iOSTargetVersion, devices: [.iphone]),
            infoPlist: InfoPlist(stringLiteral: infoPlist),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: dependencies
        )

//        let testTarget = Target(
//            name: "\(name)Tests",
//            platform: platform,
//            product: .unitTests,
//            bundleId: "\(organizationName).Tests",
//            infoPlist: .default,
//            sources: ["Tests/**"],
//            dependencies: [
//                .target(name: "\(name)"),
//                .rxTest,
//                .rxNimble
//            ])
//        return [mainTarget, testTarget]
        return [mainTarget]
    }
}
