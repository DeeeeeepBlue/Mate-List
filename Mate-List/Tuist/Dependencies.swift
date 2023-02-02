import ProjectDescription

let dependencies = Dependencies(
     swiftPackageManager: .init(
         [
            .remote(url: "https://github.com/firebase/firebase-ios-sdk.git", requirement: .exact("10.4.0")),
            .remote(url: "https://github.com/ReactiveX/RxSwift.git", requirement: .branch("main")),
            .remote(url: "https://github.com/RxSwiftCommunity/RxGesture.git", requirement: .branch("main")),
            .remote(url: "https://github.com/devxoul/RxViewController.git", requirement: .exact("2.0.0")),
            .remote(url: "https://github.com/RxSwiftCommunity/RxNimble.git", requirement: .branch("master")),
            .remote(url: "https://github.com/google/GoogleSignIn-iOS.git", requirement: .branch("main")),
            .remote(url: "https://github.com/krzysztofzablocki/Inject.git", requirement: .exact("1.2.2")),
            .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMajor(from: "5.0.1"))
         ],
         productTypes: [
            "Firebase": .framework,
            "RxSwift": .framework,
            "RxGesture": .framework,
            "RxViewController": .framework,
            "RxNimble": .framework,
            "GoogleSignIn-iOS": .framework,
            "Inject": .framework,
            "SnapKt": .framework
         ]
     ),
     platforms: [.iOS]
 )

