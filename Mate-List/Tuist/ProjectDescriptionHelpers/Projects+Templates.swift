import ProjectDescription

extension Project {
    
    public static func target(
        name: String,
        product: Product,
        infoPlist: InfoPlist = .default,
        sources: SourceFilesList,
        resources: ResourceFileElements? = nil,
        dependencies: [TargetDependency] = [],
        scripts: [TargetScript] = [],
        baseSettings: ProjectDescription.SettingsDictionary = [:],
        coreDataModels: [CoreDataModel] = []
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
            settings: .settings(
                base: [
                    "OTHER_LDFLAGS": "$(inherited)"
                ],
                configurations: [],
                defaultSettings: .recommended(excluding: [
                    "TARGETED_DEVICE_FAMILY",
                    "SWIFT_ACTIVE_COMPILATION_CONDITIONS"
                ])
            ),
            coreDataModels: coreDataModels
        )
    }
}
