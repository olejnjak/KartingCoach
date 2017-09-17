//
//  RaceTableViewCell.swift
//  KartingCoach
//
//  Created by Lukáš Hromadník on 15.09.17.
//

import UIKit

class RaceTableViewCell: UITableViewCell {
    
    private enum Values {
        static let insets = UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 15)
    }
    
    private weak var titleLabel: UILabel!
    private weak var collectionView: UICollectionView!
    
    var race: Race? {
        didSet {
            titleLabel.text = race.map { [$0.name, Formatters.dateFormatter.string(from: $0.date)].flatMap { $0 } }?.joined(separator: " - ")
        }
    }
    
    // MARK: - Initialization
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Components setup
    
    private func setup() {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 14)
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview().inset(Values.insets)
        }
        self.titleLabel = titleLabel
        
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(Values.insets.top)
            make.leading.trailing.bottom.equalToSuperview().inset(Values.insets)
        }
        self.collectionView = collectionView
    }

}

extension RaceTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: LapTimeCollectionViewCell = collectionView.dequeueCell(for: indexPath)
        cell.lapLabel.text = "#\(indexPath.row + 1)"
        cell.timeLabel.text = "00:59.029"
        return cell
    }
    
}

class LapTimeCollectionViewCell: UICollectionViewCell {
    
    weak var lapLabel: UILabel!
    weak var timeLabel: UILabel!
    
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
        lapLabel.textAlignment = .center
        contentView.addSubview(lapLabel)
        lapLabel.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview().inset(5)
        }
        self.lapLabel = lapLabel
        
        let timeLabel = UILabel()
        timeLabel.textAlignment = .center
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(lapLabel.snp.bottom).offset(5)
            make.leading.trailing.bottom.equalToSuperview().inset(5)
        }
    }

}
