//
//  HistoryCollectionViewCell.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 16.11.2024.
//

import UIKit

class HistoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "HistoryCollectionViewCell"
    
    private lazy var userView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 35
        view.layer.borderWidth = 4
        view.layer.borderColor = UIColor.customRed.cgColor
        return view
    }()
    
    private lazy var userAvatar: UIImageView = {
        let image = UIImageView(image: UIImage(named: "profileImage"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 30
        image.layer.masksToBounds = true
        image.backgroundColor = .lightGray
        return image
    }()
    
    private let userName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "mfaff[la"
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        contentView.addSubview(userView)
        
        //MARK: userView
        NSLayoutConstraint.activate([
            userView.topAnchor.constraint(equalTo: contentView.topAnchor),
            userView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            userView.widthAnchor.constraint(equalToConstant: 70),
            userView.heightAnchor.constraint(equalTo: userView.widthAnchor)
        ])
        
        userView.addSubview(userAvatar)
        
        //MARK: userAvatar
        NSLayoutConstraint.activate([
            userAvatar.centerXAnchor.constraint(equalTo: userView.centerXAnchor),
            userAvatar.centerYAnchor.constraint(equalTo: userView.centerYAnchor),
            userAvatar.widthAnchor.constraint(equalToConstant: 60),
            userAvatar.heightAnchor.constraint(equalTo: userAvatar.widthAnchor)
        ])
        
        contentView.addSubview(userName)
        
        //MARK: userName
        NSLayoutConstraint.activate([
            userName.topAnchor.constraint(equalTo: userView.bottomAnchor, constant: 5),
            userName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
}
