//
//  MainWindowFactory.swift
//  GithubExplorer
//
//  Created by adrian.szymanowski on 17/09/2020.
//

import UIKit

class MainWindowFactory: WindowFactory {
    func createkeyWindow(_ rootVC: UIViewController) -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = rootVC
        window.makeKeyAndVisible()
        return window
    }
}
