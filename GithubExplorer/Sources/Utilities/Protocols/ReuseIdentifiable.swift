//
//  ReuseIdentifiable.swift
//  GithubExplorer
//
//  Created by adrian.szymanowski on 20/09/2020.
//

import UIKit

protocol ReuseIdentifiable: class {
    static var reuseID: String { get }
}

extension ReuseIdentifiable where Self: NSObject {
    static var reuseID: String {
        String(describing: self)
    }
}

extension UITableViewCell: ReuseIdentifiable {}

