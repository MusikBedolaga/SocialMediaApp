//
//  MessageView.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 22.11.2024.
//

import UIKit

class MessageView: UIView {
    
    public let titleMessage: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "Сообщения"
        return label
    }()
    
    public let messageCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MessageCollectionViewCell.self, forCellWithReuseIdentifier: MessageCollectionViewCell.identifier)
        collectionView.backgroundColor = .white
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false

        return collectionView
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
        addSubview(messageCollection)
        
        //MARK: messageCollection
        NSLayoutConstraint.activate([
            messageCollection.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            messageCollection.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            messageCollection.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            messageCollection.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        messageCollection.gestureRecognizers?.forEach { gesture in
            messageCollection.removeGestureRecognizer(gesture)
        }
    }
    
    public func setupMessageCollection(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        messageCollection.delegate = delegate
        messageCollection.dataSource = dataSource
    }
    
}
