//
//  LapTimeTableViewCell.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 10/09/2017.
//

import UIKit

final class LapTimeTableViewCell: UITableViewCell {
    
    // MARK: Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public interface
    
    func setLapTime(time: LapTime, lapNumber: Int) {
        detailTextLabel?.text = time.description
        textLabel?.text = "#" + String(lapNumber)
    }
}
