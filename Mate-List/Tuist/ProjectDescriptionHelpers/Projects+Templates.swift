import ProjectDescription

let baseSettings: [String: SettingValue] = [
    "SWIFT_OBJC_BRIDGING_HEADER": "Source/Header.h",
]

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
        return Target (
            name: name,
            platform: .iOS,
            product: product,
            bundleId: "com.ognam.\(name.lowercased())",
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            scripts: scripts,
            dependencies: dependencies,
            settings: .settings(base: baseSettings)
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
           infoPlist: .default,
           sources: ["Tests/**"],
           resources: [],
           dependencies: [
            .target(name: name),
            .rxTest
           ])
    }
    
}
