//
//  LapTimeTableViewCell.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 10/09/2017.
//

import UIKit

protocol LapTimeCell {
    var lapTime: LapTime? { get set }
}

final class LapTimeTableViewCell: UITableViewCell, LapTimeCell {
    
    var lapTime: LapTime? {
        didSet {
            textLabel?.text = lapTime?.description
        }
    }
    
    // MARK: Initializers
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textLabel?.font = .systemFont(ofSize: 12)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

final class BestLapTimeTableViewCell: UITableViewCell, LapTimeCell {
    
    var lapTime: LapTime? {
        didSet {
            textLabel?.text = lapTime?.description
        }
    }
    
    // MARK: Initializers
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textLabel?.font = .boldSystemFont(ofSize: 12)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
