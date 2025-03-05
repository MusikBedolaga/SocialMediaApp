//
//  SettingSwitchTableViewCell.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 05.03.2025.
//

import Foundation
import UIKit

class SettingSwitchTableViewCell: UITableViewCell {
    
    weak var delegate: TableViewCellDelegate?
    
    static let identifier = "SettingSwitchTableViewCell"
    
    private let settingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Смена темы"
        return label
    }()
    
    private let settingSwitch: UISwitch = {
        let switchControl = UISwitch()
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        return switchControl
    }()
    
    var switchChanged: ((Bool) -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(settingLabel)
        contentView.addSubview(settingSwitch)

        NSLayoutConstraint.activate([
            settingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            settingLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            settingSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            settingSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        settingSwitch.addTarget(self, action: #selector(switchChangedAction), for: .valueChanged)
    }
    
    func configure(with settingTitle: String, isOn: Bool) {
        settingLabel.text = settingTitle
        settingSwitch.isOn = isOn
    }
    
    @objc private func switchChangedAction() {
        switchChanged?(settingSwitch.isOn)
        delegate?.switchChangedAction()
    }
}
