//
//  SceneDelegate.swift
//  GithubExplorer
//
//  Created by adrian.szymanowski on 15/09/2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var windowFactory: WindowFactory
    var rootControllerFactory: RootControllerFactory

    init(windowFactory: WindowFactory,
         rootControllerFactory: RootControllerFactory) {
        self.windowFactory = windowFactory
        self.rootControllerFactory = rootControllerFactory
    }
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func setWindow() {
        window = windowFactory.createkeyWindow(rootControllerFactory.mainController())
    }
}

