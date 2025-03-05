//
//  NameChangeTableViewCell.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 05.03.2025.
//

import Foundation
import UIKit

class NameChangeTableViewCell: UITableViewCell {
    
    weak var delegate: TableViewCellDelegate?
    
    static let identifier = "NameChangeTableViewCell"
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Введите имя"
        return textField
    }()
    
    private let changeNameButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Сменить имя", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(changeName), for: .touchUpInside)
        button.backgroundColor = .customRed
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(nameTextField)
        contentView.addSubview(changeNameButton)
        
        //MARK: nameTextField
        NSLayoutConstraint.activate([
            nameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            nameTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
        //MARK: changeNameButton
        NSLayoutConstraint.activate([
            changeNameButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            changeNameButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            changeNameButton.leadingAnchor.constraint(equalTo: nameTextField.trailingAnchor, constant: 5),
            changeNameButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    @objc func changeName() {
        delegate?.changeName(self)
    }
    
    public func cofigCellI(name: String) {
        nameTextField.placeholder = name
    }
}

