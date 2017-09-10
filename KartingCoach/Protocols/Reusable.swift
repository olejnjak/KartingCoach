//
//  Reusable.swift
//  KartingCoach
//
//  Created by Lukáš Hromadník on 10.09.17.
//

import UIKit

protocol Reusable { }

extension Reusable {
    
    static var reuseIdentifier: String {
        return NSStringFromClass(self as! AnyObject.Type)
    }
    
}

extension UITableViewCell: Reusable { }
