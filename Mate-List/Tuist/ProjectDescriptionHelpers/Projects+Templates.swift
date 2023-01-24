import ProjectDescription

//MARK: Project 템플릿
extension Project {
    public static func framework(
        name: String,
        organizationName: String,
        options: Options,
        package: [Package],
        target: [Target]
    ) -> Project {
        
        return Project(name: name,
                       organizationName: organizationName,
                       options: options,
                       packages: package,
                       targets: target
        )
    }
}

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
            dependencies: dependencies
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
            .rxTest,
            .rxNimble
           ])
    }
    
}
