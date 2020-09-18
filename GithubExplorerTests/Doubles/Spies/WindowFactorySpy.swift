//
//  WindowFactorySpy.swift
//  GithubExplorerTests
//
//  Created by adrian.szymanowski on 17/09/2020.
//

import UIKit
@testable import GithubExplorer

class WindowFactorySpy: WindowFactory {
    private(set) var stubbedWindow: UIWindow?
    private(set) var capturedController: UIViewController?
    
    func createKeyWindow(_ scene: UIWindowScene, _ rootVC: UIViewController) -> UIWindow {
        capturedController = rootVC
        stubbedWindow = UIWindow(frame: UIScreen.main.bounds)
        stubbedWindow?.rootViewController = rootVC
        stubbedWindow?.bounds = UIScreen.main.bounds
        return stubbedWindow!
    }
}
