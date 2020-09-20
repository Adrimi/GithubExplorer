//
//  UIViewController.swift
//  GithubExplorer
//
//  Created by adrian.szymanowski on 20/09/2020.
//

import UIKit

extension UIViewController {
    func hideInputViewWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissInputView))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissInputView() {
        view.endEditing(true)
    }
}
