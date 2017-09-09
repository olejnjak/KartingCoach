//
//  CircuitListViewController.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 09/09/2017.
//

import UIKit
import SnapKit
import ReactiveSwift
import ReactiveCocoa

final class CircuitListViewController: BaseViewController {
    
    private weak var tableView: UITableView!
    
    private let viewModel: CircuitListViewModeling
    
    // MARK: Initializers
    
    init(viewModel: CircuitListViewModeling) {
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
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
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
        
        setupBindings()
    }
    
    // MARK: Private helpers
    
    private func setupBindings() {
        tableView.reactive.reloadData <~ viewModel.circuits.map { _ in }
    }
}

extension CircuitListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CircuitTableViewCell = tableView.dequeueCell(for: indexPath)
        cell.circuit = viewModel.circuits.value[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.circuits.value.count
    }
}

extension CircuitListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
