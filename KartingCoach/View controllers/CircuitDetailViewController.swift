//
//  CircuitDetailViewController.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 09/09/2017.
//

import UIKit
import ReactiveSwift

protocol CircuitDetailFlowDelegate: class {
    func circuitDetailDidTapAddRace(_ viewController: CircuitDetailViewController, circuitVM: CircuitDetailViewModeling)
}

final class CircuitDetailViewController: BaseViewController {
    
    weak var flowDelegate: CircuitDetailFlowDelegate?
    
    private weak var tableView: UITableView!
    private weak var tableHeader: CircuitDetailHeader!
    
    private let viewModel: CircuitDetailViewModeling
    
    // MARK: Initalizers
    
    init(viewModel: CircuitDetailViewModeling) {
        self.viewModel = viewModel
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View life cycle
    
    override func loadView() {
        super.loadView()
        
        let tableView = UITableView()
        let tableHeader = createHeader()
        tableView.tableHeaderView = tableHeader
        tableView.estimatedRowHeight = 60
        tableView.allowsSelection = false
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.tableView = tableView
        self.tableHeader = tableHeader
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewRaceTapped))
        
        tableView.dataSource = self
        
        setupBindings()
    }
    
    // MARK: UI actions
    
    @objc
    private func addNewRaceTapped() {
        flowDelegate?.circuitDetailDidTapAddRace(self, circuitVM: viewModel)
    }
    
    // MARK: - Bindings
    
    private func setupBindings() {
        navigationItem.reactive.title <~ viewModel.name
        
        tableView.reactive.reloadData <~ viewModel.reloadData
        tableHeader.reactive.refresh <~ viewModel.reloadData
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RaceTableViewCell = tableView.dequeueCell(for: indexPath)
        cell.race = viewModel.race(for: indexPath)
        return cell
    }
}
