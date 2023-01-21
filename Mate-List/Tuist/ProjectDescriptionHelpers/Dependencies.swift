import ProjectDescription

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
    

    
}

public extension Package {
    static let firebase: Package = .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "8.0.0")

    static let rxSwift: Package = .package(url: "https://github.com/ReactiveX/RxSwift.git", .branch("main"))
    static let rxGesture: Package = .package(url: "https://github.com/RxSwiftCommunity/RxGesture.git",
                                             .branch("main"))
    static let rxViewController: Package = .package(url: "https://github.com/devxoul/RxViewController.git", .exact("2.0.0"))

    static let googleSignIn: Package = .package(url: "https://github.com/google/GoogleSignIn-iOS.git", .branch("main"))
    static let inject: Package = .package(url: "https://github.com/krzysztofzablocki/Inject.git", .exact("1.2.2"))
    static let snapKit: Package = .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1"))
    
    
}

// MARK: SourceFile
public extension SourceFilesList {
    static let sources: SourceFilesList = "Sources/**"
    static let tests: SourceFilesList = "Tests/**"
}

// MARK: Resource
public enum ResourceType: String {
    case xibs = "Sources/**/*.xib"
    case storyboards = "Resources/**/*.storyboard"
    case assets = "Resources/**"
}

// MARK: Extension
public extension Array where Element == FileElement {
    static func resources(with resources: [ResourceType]) -> [FileElement] {
        resources.map { FileElement(stringLiteral: $0.rawValue) }
    }
}
