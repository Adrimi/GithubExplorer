//
//  UITableView+extensions.swift
//  GithubExplorer
//
//  Created by adrian.szymanowski on 20/09/2020.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_ cell: T.Type) {
        register(cell, forCellReuseIdentifier: T.reuseID)
    }
}
