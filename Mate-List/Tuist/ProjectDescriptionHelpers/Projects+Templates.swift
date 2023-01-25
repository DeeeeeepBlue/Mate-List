import ProjectDescription

private let iOSTargetVersion = "14.0"

//MARK: Target 템플릿
extension Project {
    public static func target(
        name: String,
        product: Product,
        infoPlist: InfoPlist = .default,
        sources: SourceFilesList,
        resources: ResourceFileElements? = nil,
        dependencies: [TargetDependency] = [],
        scripts: [TargetScript] = []
    ) -> Target {
        return  Target(name: name,
                       platform: .iOS,
                       product: product,
                       bundleId: "com.ognam.\(name.lowercased())",
                       deploymentTarget: .iOS(targetVersion: iOSTargetVersion, devices: [.iphone]),
                       infoPlist: infoPlist,
                       sources: sources,
                       resources: resources,
                       headers: nil,
                       scripts: scripts,
                       dependencies: dependencies,
                       settings: nil
                )
    }
}

//MARK: Test Target 템플릿

extension Project {
    public static func testTarget(
        name: String,
        platform: Platform
    ) -> Target {
        return Target(name: "\(name)Tests",
           platform: platform,
           product: .unitTests,
           bundleId: "com.\(name)Tests",
           deploymentTarget: .iOS(targetVersion: iOSTargetVersion, devices: [.iphone]),
           infoPlist: .default,
           sources: ["Tests/**"],
           resources: [],
           dependencies: [
            .target(name: name),
            .rxTest
           ])
    }
    
}
