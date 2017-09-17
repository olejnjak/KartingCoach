//
//  LapTimeCollectionViewCell.swift
//  KartingCoach
//
//  Created by Lukáš Hromadník on 17.09.17.
//

import UIKit

class LapTimeCollectionViewCell: UICollectionViewCell {
    
    weak var lapLabel: UILabel!
    weak var timeLabel: UILabel!
    
    var isBest = false {
        didSet {
            contentView.backgroundColor = isBest ? .bestTime : UIColor(hexString: "EEEEEE")
        }
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Components setup
    
    private func setup() {
        let lapLabel = UILabel()
        lapLabel.font = .systemFont(ofSize: 14)
        lapLabel.textAlignment = .center
        contentView.addSubview(lapLabel)
        lapLabel.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview().inset(5)
        }
        self.lapLabel = lapLabel
        
        let timeLabel = UILabel()
        timeLabel.font = .systemFont(ofSize: 14)
        timeLabel.textAlignment = .center
        timeLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(lapLabel.snp.bottom).offset(5)
            make.leading.trailing.bottom.equalToSuperview().inset(5)
        }
        self.timeLabel = timeLabel
    }
    
}
