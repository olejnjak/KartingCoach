//
//  NewCircuitViewController.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 09/09/2017.
//

import UIKit

protocol NewCircuitFlowDelegate: class {
    func newCircuitDidCancel(_ viewController: NewCircuitViewController)
    func newCircuitDidAdd(_ viewController: NewCircuitViewController)
}

final class NewCircuitViewController: BaseViewController {
    
    private let viewModel: NewCircuitViewModeling
    
    private weak var tableView: UITableView!
    private weak var textField: UITextField?
    
    weak var flowDelegate: NewCircuitFlowDelegate?
    
    // MARK: Initiliazers
    
    init(viewModel: NewCircuitViewModeling) {
        self.viewModel = viewModel
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View life cycle
    
    override func loadView() {
        super.loadView()
        
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.estimatedRowHeight = 44
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.tableView = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = L10n.NewCircuit.title
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneBarButtonTapped(_:)))
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupBindings()
    }
    
    // MARK: UI actions
    
    @objc
    private func cancelTapped() {
        flowDelegate?.newCircuitDidCancel(self)
    }
    
    @objc
    private func doneBarButtonTapped(_ sender: UIBarButtonItem) {
        viewModel.addCircuit.apply(textField?.text).start()
    }
    
    // MARK: - Bindings
    
    private func setupBindings() {
        viewModel.addCircuit.errors.observeValues { [weak self] in
            switch $0 {
            case .emptyName:
                print("No empty name")
            case .exists:
                print("Circuit \(self?.textField?.text ?? "") already exists")
            }
        }
        
        viewModel.addCircuit.completed.observeValues { [weak self] in self?.flowDelegate?.newCircuitDidAdd(self!) }
    }
}

extension NewCircuitViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        textField?.becomeFirstResponder()
    }
    
}

extension NewCircuitViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TextFieldTableViewCell = tableView.dequeueCell(for: indexPath)
        cell.textField.placeholder = L10n.NewCircuit.placeholder
        self.textField = cell.textField
        return cell
    }
    
}
