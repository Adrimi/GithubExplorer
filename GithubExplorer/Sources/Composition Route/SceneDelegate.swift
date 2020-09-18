//
//  SceneDelegate.swift
//  GithubExplorer
//
//  Created by adrian.szymanowski on 15/09/2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var windowFactory: WindowFactory = MainWindowFactory()
    var rootControllerFactory: RootControllerFactory = MainRootControllerFacory()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = windowFactory.createKeyWindow(windowScene, rootControllerFactory.mainController())
    }
}

