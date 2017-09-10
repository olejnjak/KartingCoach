//
//  NewCircuitViewController.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 09/09/2017.
//

import UIKit
import ReactiveSwift

protocol NewCircuitFlowDelegate: class {
    func newCircuitDidCancel(_ viewController: NewCircuitViewController)
    func newCircuitDidAdd(_ viewController: NewCircuitViewController)
}

final class NewCircuitViewController: BaseViewController {
    
    private let viewModel: NewCircuitViewModeling
    
    private weak var tableView: UITableView!
    private weak var textField: UITextField? {
        didSet {
            guard let textField = textField else { return }
            textFieldDisposable?.dispose()
            textFieldDisposable = viewModel.name <~ textField.reactive.continuousTextValues
        }
    }
    private var textFieldDisposable: Disposable?
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        textField?.becomeFirstResponder()
    }
    
    // MARK: UI actions
    
    @objc
    private func cancelTapped() {
        view.endEditing(true)
        flowDelegate?.newCircuitDidCancel(self)
    }
    
    @objc
    private func doneBarButtonTapped(_ sender: UIBarButtonItem) {
        view.endEditing(true)
        viewModel.addCircuit.apply().start()
    }
    
    // MARK: - Bindings
    
    private func setupBindings() {
        displayErrors(for: viewModel.addCircuit)
        
        viewModel.addCircuit.completed.observeValues { [weak self] in self?.flowDelegate?.newCircuitDidAdd(self!) }
        
        navigationItem.rightBarButtonItem!.reactive.isEnabled <~ viewModel.doneEnabled
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
