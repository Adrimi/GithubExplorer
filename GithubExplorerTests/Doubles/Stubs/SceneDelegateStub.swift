//
//  SceneDelegateStub.swift
//  GithubExplorerTests
//
//  Created by adrian.szymanowski on 18/09/2020.
//

import UIKit
@testable import GithubExplorer

class SceneDelegateStub: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = TestingViewController()
        window?.makeKeyAndVisible()
    }
}

class TestingViewController: UIViewController {
    override func loadView() {
        let label = UILabel()
        label.text = "Running Unit Tests..."
        label.textAlignment = .center
        label.textColor = .white

        view = label
    }
}
