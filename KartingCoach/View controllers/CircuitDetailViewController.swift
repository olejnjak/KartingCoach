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
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.tableView = tableView
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
