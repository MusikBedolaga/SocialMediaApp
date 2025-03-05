//
//  SettingsView.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 05.03.2025.
//

import UIKit

protocol SettingsViewDelegate: AnyObject {
    func deleteUser()
}

protocol TableViewCellDelegate: AnyObject {
    func changeName(_ cell: NameChangeTableViewCell)
    func switchChangedAction()
    func didTapChangePhoto(_ cell: PhotoChangeTableViewCell)
    func changePhotoAction()
}

class SettingsView: UIView {
    
    private weak var delegate: SettingsViewDelegate?

    let settingsTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 50
        return table
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Удалить", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(deleteUser), for: .touchUpInside)
        return button
    }()

    init(delegate: SettingsViewDelegate) {
        super.init(frame: .zero)
        setupView()
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        [settingsTable, deleteButton].forEach({ addSubview($0) })
        
        let sideInsert: CGFloat = 10
        
        //MARK: settingsTable
        NSLayoutConstraint.activate([
            settingsTable.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            settingsTable.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            settingsTable.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
        
        //MARK: deleteButton
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: settingsTable.bottomAnchor, constant: 10),
            deleteButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: sideInsert),
            deleteButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -sideInsert),
            deleteButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -sideInsert)
        ])
    }
    
    public func setupTable(dataSource: UITableViewDataSource, delegate: UITableViewDelegate) {
        settingsTable.dataSource = dataSource
        settingsTable.delegate = delegate
        settingsTable.register(PhotoChangeTableViewCell.self, forCellReuseIdentifier: PhotoChangeTableViewCell.identifier)
        settingsTable.register(NameChangeTableViewCell.self, forCellReuseIdentifier: NameChangeTableViewCell.identifier)
        settingsTable.register(SettingSwitchTableViewCell.self, forCellReuseIdentifier: SettingSwitchTableViewCell.identifier)
    }
    
    @objc private func deleteUser() {
        delegate?.deleteUser()
    }
}
