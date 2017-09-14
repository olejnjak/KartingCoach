//
//  UICollectionViewExtensions.swift
//  KartingCoach
//
//  Created by Lukáš Hromadník on 14.09.17.
//

import UIKit

extension UICollectionView {
    
    func dequeueCell<Cell: UICollectionViewCell>(for indexPath: IndexPath) -> Cell {
        register(Cell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
        return dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath)
    }

}
