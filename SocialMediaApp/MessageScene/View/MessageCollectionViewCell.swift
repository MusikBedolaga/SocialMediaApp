//
//  MessageCollectionViewCell.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 22.11.2024.
//

import UIKit

class MessageCollectionViewCell: UICollectionViewCell {
    static let identifier = "MessageCollectionViewCell"
    
    
    override var isHighlighted: Bool {
        didSet {
            // Изменяем цвет на синий, если ячейка выделена (highlighted)
            backgroundColor = isHighlighted ? UIColor.lightBlue : UIColor.white
        }
    }
        
    override var isSelected: Bool {
        didSet {
            // Также изменяем цвет, если ячейка выделена (selected)
            backgroundColor = isSelected ? UIColor.lightBlue  : UIColor.white
        }
    }
    
    private let userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 28
        imageView.image = UIImage(named: "legaImage")
        return imageView
    }()
    
    private let userName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.text = "userName"
        return label
    }()
    
    private let lastMessage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10)
//        label.numberOfLines = 0
        label.textColor = .black
        label.text = "Some message"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
        setupShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        backgroundColor = .white
        
        [userImage, userName, lastMessage].forEach({ contentView.addSubview($0) })
        
        //MARK: userImage
        NSLayoutConstraint.activate([
            userImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            userImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            userImage.heightAnchor.constraint(equalToConstant: 56),
            userImage.widthAnchor.constraint(equalTo: userImage.heightAnchor)
        ])
        
        //MARK: userName
        NSLayoutConstraint.activate([
            userName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            userName.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 10),
            userName.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        
        //MARK: lastMessage
        let topAnchor =  lastMessage.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 5)
//        let bottomAnchor = lastMessage.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant:  -5)
        NSLayoutConstraint.activate([
            topAnchor,
            lastMessage.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 10),
//            bottomAnchor
        ])
    }
    
    public func setupCell(userImage: UIImage?, userName: String) {
        self.userImage.image = userImage ?? UIImage(named: "legaImage")
        self.userName.text = userName
    }
    
    private func setupShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 10, height: 5)
        self.layer.shadowRadius = 6
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 8
    }
}
