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
            collectionView.reloadData()
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
        titleLabel.font = .systemFont(ofSize: 16)
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview().inset(Values.insets)
        }
        self.titleLabel = titleLabel
        
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 80, height: 49)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(Values.insets.top)
            make.leading.trailing.bottom.equalToSuperview().inset(Values.insets)
            make.height.equalTo(50)
        }
        self.collectionView = collectionView
    }

}

extension RaceTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return race?.lapTimes.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let lapTime = race?.lapTimes[indexPath.item]
        let isBest = lapTime == race?.bestTime
        
        let cell: LapTimeCollectionViewCell = collectionView.dequeueCell(for: indexPath)
        cell.lapLabel.text = "#\(indexPath.row + 1)"
        cell.timeLabel.text = lapTime?.description
        cell.isBest = isBest
        return cell
    }
    
}
