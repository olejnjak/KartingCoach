//
//  CircuitDetailHeader.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 10/09/2017.
//

import UIKit
import ReactiveSwift

protocol CircuitDetailHeaderViewModeling {
    var name: Property<String> { get }
    var bestTime: Property<LapTime?> { get }
    var averageTime: Property<LapTime?> { get }
}

final class CircuitDetailHeader: UIView {
    
    var circuit: CircuitDetailHeaderViewModeling? {
        didSet {
            bestRow.timeLabel.text = circuit?.bestTime.value?.description ?? L10n.Basic.noTime
            averageRow.timeLabel.text = circuit?.averageTime.value?.description ?? L10n.Basic.noTime
        }
    }
    
    private weak var bestRow: CircuitDetailHeaderRow!
    private weak var averageRow: CircuitDetailHeaderRow!
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let bestRow = CircuitDetailHeaderRow(frame: frame)
        bestRow.nameLabel.text = L10n.CircuitDetail.bestTime
        addSubview(bestRow)
        bestRow.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(15).priority(999)
            make.top.equalTo(10)
        }
        self.bestRow = bestRow
        
        let averageRow = CircuitDetailHeaderRow(frame: frame)
        averageRow.nameLabel.text = L10n.CircuitDetail.averageTime
        addSubview(averageRow)
        averageRow.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(bestRow)
            make.top.equalTo(bestRow.snp.bottom).offset(5)
            make.bottom.equalTo(-10)
        }
        self.averageRow = averageRow
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private final class CircuitDetailHeaderRow: UIView {
    
    weak var nameLabel: UILabel!
    weak var timeLabel: UILabel!
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let nameLabel = UILabel()
        nameLabel.font = .boldSystemFont(ofSize: 12)
        nameLabel.adjustsFontSizeToFitWidth = true
        addSubview(nameLabel)
        self.nameLabel = nameLabel
        
        let timeLabel = UILabel()
        timeLabel.font = .systemFont(ofSize: 12)
        timeLabel.adjustsFontSizeToFitWidth = true
        timeLabel.setContentHuggingPriority(.required, for: .horizontal)
        timeLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        addSubview(timeLabel)
        self.timeLabel = timeLabel
        
        timeLabel.snp.makeConstraints { (make) in
            make.trailing.centerY.equalToSuperview().priority(999)
            make.top.greaterThanOrEqualToSuperview().priority(999)
            make.bottom.lessThanOrEqualToSuperview().priority(999)
            make.width.equalToSuperview().dividedBy(3).priority(999)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.leading.top.bottom.equalToSuperview().priority(999)
            make.trailing.equalTo(timeLabel.snp.leading).offset(-10).priority(999)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
