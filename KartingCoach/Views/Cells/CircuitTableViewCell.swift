//
//  CircuitTableViewCell.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 09/09/2017.
//

import UIKit

final class CircuitTableViewCell: UITableViewCell {
    
    var circuit: Circuit? {
        didSet {
            let bestTime = circuit?.bestTime
            
            textLabel?.text = circuit?.name
            detailTextLabel?.text = bestTime?.description
            accessoryType = bestTime.map { _ in .disclosureIndicator } ?? .none
        }
    }
    
    // MARK: Initializers
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
