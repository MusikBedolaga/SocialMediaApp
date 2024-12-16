//
//  CommentsCollectionViewCell.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 02.12.2024.
//

import UIKit

class CommentsCollectionViewCell: UICollectionViewCell {
    static let identifier = "CommentsCollectionViewCell"
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private let userName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Кто-то"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let commentText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        label.numberOfLines = 0
        label.backgroundColor = .blue
        return label
    }()
    
    private let likeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "heart.fill")
        imageView.tintColor = .customRed
        return imageView
    }()
    
    private let countLikesView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "12"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
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
        [userImageView, userName, commentText, countLikesView, likeImageView].forEach({ contentView.addSubview($0) })
        
        //MARK: userImageView
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -10),
            userImageView.widthAnchor.constraint(equalToConstant: 40),
            userImageView.heightAnchor.constraint(equalTo: userImageView.widthAnchor)
        ])
        
        //MARK: userName
        NSLayoutConstraint.activate([
            userName.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor),
            userName.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 5)
        ])
        
        //MARK: commentText
        NSLayoutConstraint.activate([
            commentText.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 5),
            commentText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            commentText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            commentText.bottomAnchor.constraint(equalTo: countLikesView.bottomAnchor, constant: -40)
        ])
        
        //MARK: countLikesView
        NSLayoutConstraint.activate([
            countLikesView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            countLikesView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            countLikesView.widthAnchor.constraint(equalToConstant: 40),
        ])
        
        //MARK: likeImageView
        NSLayoutConstraint.activate([
            likeImageView.centerYAnchor.constraint(equalTo: countLikesView.centerYAnchor),
            likeImageView.trailingAnchor.constraint(equalTo: countLikesView.leadingAnchor, constant: -5),
            likeImageView.heightAnchor.constraint(equalTo: countLikesView.heightAnchor)
        ])
    }
}
