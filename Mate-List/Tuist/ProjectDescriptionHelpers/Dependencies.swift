//
//  Dependencies.swift
//  ProjectDescriptionHelpers
//
//  Created by 강민규 on 2023/02/07.


import ProjectDescription

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
    static let thirdparty: TargetDependency = .project(target: "Thirdparty",
                                                              path: .relativeToRoot("Projects/Thirdparty"))
    
    static let service: TargetDependency = .project(target: "Service",
                                                              path: .relativeToRoot("Projects/Service"))
    static let utility: TargetDependency = .project(target: "Utility",
                                                              path: .relativeToRoot("Projects/Utility"))
}

// MARK: Package
public extension TargetDependency {
    static let firebaseAnalytics: TargetDependency = .package(product: "FirebaseAnalytics")
    static let firebaseAuth: TargetDependency =
        .package(product: "FirebaseAuth")
    static let firebaseDatabase: TargetDependency =
        .package(product: "FirebaseDatabase")
    static let firebaseFirestore: TargetDependency =
        .package(product: "FirebaseFirestore")
    static let firebaseStorage: TargetDependency =
        .package(product: "FirebaseStorage")
    static let firebaseMessaging: TargetDependency = .package(product: "FirebaseMessaging")
    static let firebaseCrashlytics: TargetDependency = .package(product: "FirebaseCrashlytics")

    static let rxSwift: TargetDependency = .package(product: "RxSwift")
    static let rxCocoa: TargetDependency = .package(product: "RxCocoa")
    static let rxGesture: TargetDependency = .package(product: "RxGesture")
    static let rxRelay: TargetDependency = .package(product: "RxRelay")
    static let rxViewController: TargetDependency = .package(product: "RxViewController")

    static let snapKit: TargetDependency = .package(product: "SnapKit")
    static let flexLayout: TargetDependency = .package(product: "Flex")
    static let googleSignIn: TargetDependency = .package(product: "GoogleSignIn")
    static let inject: TargetDependency = .package(product: "Inject")

    static let rxTest: TargetDependency = .package(product: "RxTest")
    static let rxNimble: TargetDependency = .package(product: "RxNimble")
}

public extension Package {
    static let firebase: Package = .package(url: "https://github.com/firebase/firebase-ios-sdk.git", .branch("master"))

    static let rxSwift: Package = .package(url: "https://github.com/ReactiveX/RxSwift.git", .branch("main"))
    static let rxGesture: Package = .package(url: "https://github.com/RxSwiftCommunity/RxGesture.git",
                                             .branch("main"))
    static let rxViewController: Package = .package(url: "https://github.com/devxoul/RxViewController.git", .exact("2.0.0"))
    
    static let rxNimble: Package = .package(url: "https://github.com/RxSwiftCommunity/RxNimble.git", .branch("master"))

    static let googleSignIn: Package = .package(url: "https://github.com/google/GoogleSignIn-iOS.git", .branch("main"))
    static let inject: Package = .package(url: "https://github.com/krzysztofzablocki/Inject.git", .exact("1.2.2"))
    
    
    static let snapKit: Package = .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1"))


}
