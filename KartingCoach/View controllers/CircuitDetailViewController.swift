//
//  CircuitDetailViewController.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 09/09/2017.
//

import UIKit

final class CircuitDetailViewController: BaseViewController {
    
    private weak var tableView: UITableView!
    
    private let viewModel: CircuitDetailViewModeling
    
    // MARK: Initalizers
    
    init(viewModel: CircuitDetailViewModeling) {
        self.viewModel = viewModel
        super.init()
        title = viewModel.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View life cycle
    
    override func loadView() {
        super.loadView()
        
        let tableView = UITableView()
        tableView.tableHeaderView = createHeader()
        tableView.estimatedRowHeight = 60
        tableView.allowsSelection = false
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.tableView = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: Private helpers
    
    private func createHeader() -> CircuitDetailHeader {
        let fittingSize = UIScreen.main.bounds.size
        let header = CircuitDetailHeader(frame: CGRect(origin: .zero, size: fittingSize))
        header.circuit = viewModel
        header.frame = CGRect(origin: .zero, size: header.systemLayoutSizeFitting(fittingSize))
        return header
    }
}

extension CircuitDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.races.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.races[section].lapTimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let lapTime = viewModel.races[indexPath.section].lapTimes[indexPath.row]
        let cell: UITableViewCell & LapTimeCell
        
        if lapTime == viewModel.bestTime {
            cell = tableView.dequeueCell(for: indexPath) as BestLapTimeTableViewCell
        } else {
            cell = tableView.dequeueCell(for: indexPath) as LapTimeTableViewCell
        }
        
        cell.setLapTime(time: lapTime, lapNumber: indexPath.row + 1)
        
        return cell
    }
}

extension CircuitDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let race = viewModel.races[section]
        let name = [race.name, Formatters.dateFormatter.string(from: race.date)]
            .flatMap { $0 }
            .joined(separator: " - ")
        return name
    }
    
}
