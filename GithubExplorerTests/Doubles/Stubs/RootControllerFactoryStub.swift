//
//  RootControllerFactoryStub.swift
//  GithubExplorerTests
//
//  Created by adrian.szymanowski on 17/09/2020.
//

import UIKit
@testable import GithubExplorer

class RootControllerFactoryStub: RootControllerFactory {
    class UnitTestViewController: UIViewController {
        override func loadView() {
            view = {
               let label = UILabel()
                label.text = "Running Unit Tests..."
                label.textAlignment = .center
                label.textColor = .white
                return label
            }()
        }
    }
    
    private let stubController = UnitTestViewController()
    
    func mainController() -> UIViewController {
        stubController
    }
}

