//
//  WindowFactory.swift
//  GithubExplorer
//
//  Created by adrian.szymanowski on 17/09/2020.
//

import UIKit

protocol WindowFactory {
    func createkeyWindow(_ rootVC: UIViewController) -> UIWindow
}
