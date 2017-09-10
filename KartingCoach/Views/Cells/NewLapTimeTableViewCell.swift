//
//  NewLapTimeTableViewCell.swift
//  KartingCoach
//
//  Created by Lukáš Hromadník on 10.09.17.
//

import UIKit
import ReactiveSwift

class NewLapTimeTableViewCell: UITableViewCell {
    
    var lapTime: LapTime? {
        didSet {
            updateValues()
        }
    }
    
    var value: LapTime {
        let minutes = Int(minutesTextField?.text ?? "") ?? 0
        let seconds = Int(secondsTextField?.text ?? "") ?? 0
        let miliseconds = Int(milisecondsTextField?.text ?? "") ?? 0

        return LapTime(minutes: minutes, seconds: seconds, miliseconds: miliseconds)
    }
    
    weak var numberLabel: UILabel!
    private weak var minutesTextField: UITextField!
    private weak var secondsTextField: UITextField!
    private weak var milisecondsTextField: UITextField!
    
    // MARK: - Initialization
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        setup()
        setupBindings()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Components setup
    
    private func setup() {
        let numberLabel = UILabel()
        contentView.addSubview(numberLabel)
        numberLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(15)
            make.leading.equalToSuperview().inset(15)
        }
        self.numberLabel = numberLabel
        
        let minutesTextField = numberTextFieldFactory()
        minutesTextField.placeholder = "00"
        contentView.addSubview(minutesTextField)
        minutesTextField.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15))
            make.leading.greaterThanOrEqualTo(numberLabel.snp.trailing).offset(15)
            make.width.equalTo(30)
        }
        self.minutesTextField = minutesTextField
        
        let secondsTextField = numberTextFieldFactory()
        secondsTextField.placeholder = "00"
        contentView.addSubview(secondsTextField)
        secondsTextField.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15))
            make.leading.equalTo(minutesTextField.snp.trailing).offset(15)
            make.width.equalTo(30)
        }
        self.secondsTextField = secondsTextField
        
        let milisecondsTextField = numberTextFieldFactory()
        milisecondsTextField.placeholder = "000"
        contentView.addSubview(milisecondsTextField)
        milisecondsTextField.snp.makeConstraints { (make) in
            make.top.trailing.bottom.equalToSuperview().inset(UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15))
            make.leading.equalTo(secondsTextField.snp.trailing).offset(15)
            make.width.equalTo(45)
        }
        self.milisecondsTextField = milisecondsTextField
    }
    
    private func setupBindings() {
        minutesTextField.reactive.continuousTextValues
            .map { $0 ?? "" }
            .filter { $0.count == 2 }
            .observeValues { [weak self] _ in self?.secondsTextField.becomeFirstResponder() }
        
        secondsTextField.reactive.continuousTextValues
            .map { $0 ?? "" }
            .filter { $0.count == 2 }
            .observeValues { [weak self] _ in self?.milisecondsTextField.becomeFirstResponder() }
        
        milisecondsTextField.reactive.continuousTextValues
            .map { $0 ?? "" }
            .filter { $0.count == 3 }
            .observeValues { [weak self] _ in self?.milisecondsTextField.resignFirstResponder() }
    }
    
    // MARK: - Helpers
    
    private func maxLength(for textField: UITextField) -> Int {
        switch textField {
        case minutesTextField, secondsTextField:
            return 2
        case milisecondsTextField:
            return 3
        default:
            return 0
        }
    }
    
    private func numberTextFieldFactory() -> UITextField {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.returnKeyType = .next
        textField.delegate = self
        
        return textField
    }
    
    private func updateValues() {
        guard lapTime != .zero else { return }
        minutesTextField.text = lapTime?.minutes.description
        secondsTextField.text = lapTime?.seconds.description
        milisecondsTextField.text = lapTime?.miliseconds.description
    }
    
}


extension NewLapTimeTableViewCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldLength = textField.text?.count ?? 0
        let rangeLength = range.length
        let replacementLength = string.count
        
        return oldLength - rangeLength + replacementLength <= maxLength(for: textField)
    }
    
}
