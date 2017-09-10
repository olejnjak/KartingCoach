//
//  UITableViewExtensions.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 09/09/2017.
//

import UIKit

extension UITableView {
    
    func dequeueCell<Cell: UITableViewCell>(for indexPath: IndexPath) -> Cell {
        let cellIdentifier = NSStringFromClass(Cell.self)
        register(Cell.self, forCellReuseIdentifier: cellIdentifier)
        return dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! Cell
    }
    
}
