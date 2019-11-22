//
//  BaseTableViewController.swift
//  Loadable_Example
//
//  Created by Matthew Pierce on 18/11/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class BaseTableViewController: UIViewController {
    
    func registerCell<T: UITableViewCell>(_ type: T.Type, in tableView: UITableView) {
        let nib = UINib(nibName: type.computedReuseIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: type.computedReuseIdentifier)
    }
    
    func dequeueCell<T: UITableViewCell>(_ type: T.Type, at indexPath: IndexPath, in tableView: UITableView) -> T {
        return tableView.dequeueReusableCell(withIdentifier: type.computedReuseIdentifier, for: indexPath) as! T
    }
    
}

