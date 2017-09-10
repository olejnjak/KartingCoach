//
//  TextFieldTableViewCell.swift
//  KartingCoach
//
//  Created by Lukáš Hromadník on 10.09.17.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {
    
    private enum Values {
        static let verticalPadding: CGFloat = 5
        static let horizontalPadding: CGFloat = 15
    }
    
    weak var textField: UITextField!
    
    // MARK: - Initialization
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Components setup
    
    private func setup() {
        let textField = UITextField()
        textField.clearButtonMode = .always
        contentView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: Values.verticalPadding, left: Values.horizontalPadding, bottom: Values.verticalPadding, right: Values.horizontalPadding))
            make.height.greaterThanOrEqualTo(34)
        }
        self.textField = textField
    }

}
