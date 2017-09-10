//
//  LapTimeTableViewCell.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 10/09/2017.
//

import UIKit

protocol LapTimeCell: class {
    func setLapTime(time: LapTime, lapNumber: Int)
}

final class LapTimeTableViewCell: UITableViewCell, LapTimeCell {
    
    // MARK: Initializers
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class BestLapTimeTableViewCell: UITableViewCell, LapTimeCell {
    
    // MARK: Initializers
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LapTimeCell where Self: UITableViewCell {
    func setLapTime(time: LapTime, lapNumber: Int) {
        detailTextLabel?.text = time.description
        textLabel?.text = "#" + String(lapNumber)
    }
}
