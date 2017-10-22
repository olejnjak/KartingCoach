//
//  NewRaceViewController.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 10/09/2017.
//

import UIKit
import ReactiveSwift
import SimpleImagePicker

protocol NewRaceFlowDelegate: class {
    func newRaceDidCancel(_ viewController: NewRaceViewController)
    func newRaceDidSave(_ viewController: NewRaceViewController)
}

final class NewRaceViewController: BaseViewController {
    
    // ViewModel
    private let viewModel: NewRaceViewModeling
    
    // Views
    private weak var tableView: UITableView!
    
    // Flow
    weak var flowDelegate: NewRaceFlowDelegate?
    
    private lazy var imagePicker: ImagePicker = {
        let permissionConfig = PermissionAlertConfiguration(title: "Title", message: "Message", settings: "Settings")
        let picker = ImagePicker(cancelTitle: L10n.Basic.cancel, permissionConfig: permissionConfig) { image in
            
        }
        
        return picker
    }()
    
    // MARK: Initializers
    
    init(viewModel: NewRaceViewModeling) {
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
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.tableView = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = L10n.NewRace.title
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        
        let saveItem = UIBarButtonItem(title: L10n.NewRace.save, style: .plain, target: self, action: #selector(saveBarButtonTapped(_:)))
        let ocrItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(ocrBarButtonTapped(_:)))
        
        navigationItem.rightBarButtonItems = [saveItem, ocrItem]
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setupBindings()
    }
    
    // MARK: UI actions
    
    @objc
    private func cancelTapped() {
        flowDelegate?.newRaceDidCancel(self)
    }
    
    @objc
    private func saveBarButtonTapped(_ sender: UIBarButtonItem) {
        updateLapTimes()
        viewModel.save()
        flowDelegate?.newRaceDidSave(self)
    }
    
    @objc
    private func ocrBarButtonTapped(_ sender: UIBarButtonItem) {
        imagePicker.presentImagePicker(withSources: [
            ImagePickerSource(source: .camera, title: "Camera"),
            ImagePickerSource(source: .photoLibrary, title: "Photo library")
            ], mediaTypes: [ImagePickerMediaType.image], from: self)
    }
    
    // MARK: - Bindings
    
    private func setupBindings() {
        tableView.reactive.reloadData <~ viewModel.items.producer.map { _ in }
    }
    
    // MARK: - Helpers
    
    private func updateLapTimes() {
        var lapTimes: [LapTime] = []
        for item in 0..<viewModel.items.value.count {
            let indexPath = IndexPath(item: item, section: 0)
            guard let cell = tableView.cellForRow(at: indexPath) as? NewLapTimeTableViewCell else { continue }
            // Nelibi se mi to...
            lapTimes.append(cell.value)
        }
        viewModel.items.value = lapTimes
    }

}

extension NewRaceViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.value.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == viewModel.items.value.count {
            let cell = UITableViewCell()
            cell.textLabel?.text = L10n.NewRace.add
            
            return cell
        } else {
            let cell: NewLapTimeTableViewCell = tableView.dequeueCell(for: indexPath)
            cell.numberLabel.text = "#\(indexPath.row + 1)"
            cell.lapTime = viewModel.items.value[indexPath.row]
            
            return cell
        }
    }
    
}

extension NewRaceViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row == viewModel.items.value.count else { return }
        updateLapTimes()
        viewModel.addNewLap()
    }
    
}
