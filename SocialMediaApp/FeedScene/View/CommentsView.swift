//
//  CommentsView.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 02.12.2024.
//

import UIKit

protocol CommentsViewDelegate: AnyObject {
    func addComment()
}

class CommentsView: UIView {
    
    private weak var delegate: CommentsViewDelegate?
    
    private let navbar: UINavigationBar = {
        let navbar = UINavigationBar()
        navbar.translatesAutoresizingMaskIntoConstraints = false
        return navbar
    }()
    
    private let navItem = UINavigationItem(title: "Комментарии")
    
    public let commentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(CommentsCollectionViewCell.self, forCellWithReuseIdentifier: CommentsCollectionViewCell.identifier)
//        collection.backgroundColor = .red
        return collection
    }()
    
    private let createComment: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = .customLightGray
        textView.backgroundColor = .black
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 2
        textView.layer.cornerRadius = 10
        return textView
    }()
    
    private let addCommentButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrowshape.right.circle.fill"), for: .normal)
        button.backgroundColor = .customRed
        button.tintColor = .white
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(addComment), for: .touchUpInside)
        return button
    }()
    
    init(delegate: CommentsViewDelegate) {
        super.init(frame: .zero)
        self.delegate = delegate
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        backgroundColor = .white
        
        navbar.setItems([navItem], animated: false)
        
        [navbar, commentCollectionView, createComment, addCommentButton].forEach({ addSubview($0) })
        
        //MARK: navbar
        NSLayoutConstraint.activate([
            navbar.topAnchor.constraint(equalTo: self.topAnchor),
            navbar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            navbar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            navbar.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        //MARK: commentCollectionView
        NSLayoutConstraint.activate([
            commentCollectionView.topAnchor.constraint(equalTo: navbar.bottomAnchor),
            commentCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            commentCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            commentCollectionView.bottomAnchor.constraint(equalTo: createComment.topAnchor, constant: -10)
        ])
        
        //MARK: createComment
        NSLayoutConstraint.activate([
            createComment.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            createComment.trailingAnchor.constraint(equalTo: addCommentButton.leadingAnchor, constant: -5),
            createComment.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            createComment.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        //MARK: addCommentButton
        NSLayoutConstraint.activate([
            addCommentButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            addCommentButton.leadingAnchor.constraint(equalTo: createComment.trailingAnchor, constant: 5),
            addCommentButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            addCommentButton.widthAnchor.constraint(equalToConstant: 40),
            addCommentButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    public func setupCollection(dataSource: UICollectionViewDataSource, delegate: UICollectionViewDelegate) {
        commentCollectionView.delegate = delegate
        commentCollectionView.dataSource = dataSource
    }
    
    public func setupTextView(delegate: UITextViewDelegate) {
        createComment.delegate = delegate
    }
    
    @objc private func addComment() {
        delegate?.addComment()
    }
}
