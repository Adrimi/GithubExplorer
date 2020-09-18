//
//  WindowFactory.swift
//  GithubExplorer
//
//  Created by adrian.szymanowski on 17/09/2020.
//

import UIKit

protocol WindowFactory {
    func createKeyWindow(_ scene: UIWindowScene, _ rootVC: UIViewController) -> UIWindow
}
