//
//  MainWindowFactory.swift
//  GithubExplorer
//
//  Created by adrian.szymanowski on 17/09/2020.
//

import UIKit

class MainWindowFactory: WindowFactory {
    func createKeyWindow(_ scene: UIWindowScene, _ rootVC: UIViewController) -> UIWindow {
        let window = UIWindow(windowScene: scene)
        window.rootViewController = rootVC
        window.makeKeyAndVisible()
        return window
    }
}
