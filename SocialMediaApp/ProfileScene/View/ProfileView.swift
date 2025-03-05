//
//  ProfileView.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 19.11.2024.
//

import UIKit

class FollowView: UIView {
    
    private let countFollowes: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = "2.5K"
        return label
    }()
    
    private let textFollowes: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .customBlue
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Followes"
        return label
    }()
    
    private let stackFollowes: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    
    private let countFollowing: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = "7001"
        return label
    }()
    
    private let textFollowing: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .customBlue
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Following"
        return label
    }()
    
    private let stackFollowing: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
                
        [stackFollowes, stackFollowing].forEach({ addSubview($0) })
        
        [countFollowes, textFollowes].forEach({ stackFollowes.addArrangedSubview($0) })
        
        //MARK: stackFollowes
        NSLayoutConstraint.activate([
            stackFollowes.topAnchor.constraint(equalTo: self.topAnchor),
            stackFollowes.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackFollowes.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        [countFollowing, textFollowing].forEach({ stackFollowing.addArrangedSubview($0) })
        
        //MARK: stackFollowing
        NSLayoutConstraint.activate([
            stackFollowing.topAnchor.constraint(equalTo: self.topAnchor),
            stackFollowing.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackFollowing.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}


class ProfileView: UIView {
    
    public let backToFeedButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrowshape.turn.up.backward"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .customRed
        button.layer.cornerRadius = 20
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return button
    }()
    
    public let checkNewMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "envelope"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .customRed
        button.layer.cornerRadius = 20
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return button
    }()
    
    private let scroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightBlue
        return view
    }()
    
    private let profileView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.customRed.cgColor
        view.layer.cornerRadius = 50;
        view.layer.borderWidth = 2;
        return view
    }()
    
    private let profileImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "profileImage"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 40
        return imageView
    }()
    
    private let followView: FollowView = FollowView()
    
    private let postLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "Posts"
        return label
    }()
    
    public let postCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ProfilePostCollectionViewCell.self, forCellWithReuseIdentifier: ProfilePostCollectionViewCell.identifier)
        collectionView.layer.cornerRadius = 20
        collectionView.layer.borderWidth = 5
        collectionView.layer.borderColor = UIColor.white.cgColor
        return collectionView
    }()
    
    private let userTag: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.text = "@tag"
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(scroll)
                
        //MARK: scroll
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scroll.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        
        [mainView].forEach({ scroll.addSubview($0) })
        
        //MARK: mainView
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: scroll.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
            mainView.widthAnchor.constraint(equalTo: scroll.widthAnchor),
            mainView.heightAnchor.constraint(greaterThanOrEqualTo: scroll.heightAnchor)
        ])
        
        [profileView, followView, postLabel, postCollection, userTag].forEach({ mainView.addSubview($0) })
        
        //MARK: profileView
        NSLayoutConstraint.activate([
            profileView.widthAnchor.constraint(equalToConstant: 100),
            profileView.heightAnchor.constraint(equalTo: profileView.widthAnchor),
            profileView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 50),
            profileView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor)
        ])
        
        profileView.addSubview(profileImage)
        
        //MARK: profileImage
        NSLayoutConstraint.activate([
            profileImage.widthAnchor.constraint(equalToConstant: 80),
            profileImage.heightAnchor.constraint(equalTo: profileImage.widthAnchor),
            profileImage.centerXAnchor.constraint(equalTo: profileView.centerXAnchor),
            profileImage.centerYAnchor.constraint(equalTo: profileView.centerYAnchor)
        ])
        
        //MARK: followView
        NSLayoutConstraint.activate([
            followView.topAnchor.constraint(equalTo: profileView.centerYAnchor),
            followView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 48),
            followView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -48)
        ])
        
        //MARK: userTag
        NSLayoutConstraint.activate([
            userTag.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            userTag.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 15)
        ])
        
        //MARK: postLabel
        NSLayoutConstraint.activate([
            postLabel.topAnchor.constraint(equalTo: userTag.bottomAnchor, constant: 20),
            postLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor)
        ])
        
        //MARK: postCollection
        NSLayoutConstraint.activate([
            postCollection.topAnchor.constraint(equalTo: postLabel.bottomAnchor, constant: 10),
            postCollection.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            postCollection.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            postCollection.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10)
        ])
    }
    
    public func setupProfilePostCollection(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        postCollection.delegate = delegate
        postCollection.dataSource = dataSource
    }
    
    public func setupUser(tag: String) {
        userTag.text = tag
    }
}
