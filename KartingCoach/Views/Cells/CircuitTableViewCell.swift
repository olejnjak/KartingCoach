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
            textLabel?.text = circuit?.name
            detailTextLabel?.text = circuit?.bestTime?.description
        }
    }
    
    // MARK: Initializers
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }    
}
