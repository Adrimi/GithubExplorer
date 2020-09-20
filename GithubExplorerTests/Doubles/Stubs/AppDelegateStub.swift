//
//  AppDelegateStub.swift
//  GithubExplorerTests
//
//  Created by adrian.szymanowski on 18/09/2020.
//

import UIKit

@objc(AppDelegateStub)
final class AppDelegateStub: UIResponder, UIApplicationDelegate, UISceneDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Remove any cached scene configurations to ensure that AppDelegateStub.application(_:configurationForConnecting:options:) is called and SceneDelegateStub will be used when running unit tests. NOTE: THIS IS PRIVATE API AND MAY BREAK IN THE FUTURE!
        application.openSessions.forEach {
            application.perform(Selector(("_removeSessionFromSessionSet:")), with: $0)
        }
        
        return true
    }
    
    // MARK: UISceneSession lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        let sceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfiguration.delegateClass = SceneDelegateStub.self

        return sceneConfiguration
    }
}
