//
//  FeedView.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 09.11.2024.
//

import UIKit

class FeedView: UIView {

    public let addPostButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "camera"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .customRed
        button.layer.cornerRadius = 20
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return button
    }()
    
    public let notificationsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "bell.badge"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .customRed
        button.layer.cornerRadius = 20
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return button
    }()
    
    public let postCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(PostlCollectionViewCell.self, forCellWithReuseIdentifier: PostlCollectionViewCell.identifier)
        collection.backgroundColor = .clear
        return collection
    }()
    
    public let historyCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(HistoryCollectionViewCell.self, forCellWithReuseIdentifier: HistoryCollectionViewCell.identifier)
        collection.backgroundColor = .clear
        return collection
    }() 
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        
        backgroundColor = .white
        
        addSubview(historyCollection)
        
        //MARK: historyCollection
        NSLayoutConstraint.activate([
            historyCollection.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            historyCollection.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            historyCollection.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            historyCollection.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        addSubview(postCollection)
        
        //MARK: postCollection
        NSLayoutConstraint.activate([
            postCollection.topAnchor.constraint(equalTo: historyCollection.bottomAnchor, constant: 16),
            postCollection.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            postCollection.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            postCollection.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    public func setupPostCollectionView(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        postCollection.delegate = delegate
        postCollection.dataSource = dataSource
    }
    
    public func setupHistoryCollectionView(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        historyCollection.delegate = delegate
        historyCollection.dataSource = dataSource
    }
}
