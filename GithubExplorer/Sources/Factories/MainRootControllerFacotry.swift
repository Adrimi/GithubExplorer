//
//  MainRootControllerFacotry.swift
//  GithubExplorer
//
//  Created by adrian.szymanowski on 17/09/2020.
//

import UIKit

class MainRootControllerFacory: RootControllerFactory {
    func mainController() -> UIViewController {
        let viewController = HomeViewController()
        let navigationController = UINavigationController()
        navigationController.addChild(viewController)
        return navigationController
    }
}
