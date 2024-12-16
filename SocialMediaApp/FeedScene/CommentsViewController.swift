//
//  CommentsViewController.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 02.12.2024.
//

import UIKit

class CommentsViewController: UIViewController {

    private lazy var commentsView = CommentsView(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view = commentsView
        
        commentsView.setupTextView(delegate: self)
        
        commentsView.setupCollection(dataSource: self, delegate: self)
    }
}

//MARK: - UITextViewDelegate
extension CommentsViewController: UITextViewDelegate { }

//MARK: - CommentsViewDelegate
extension CommentsViewController: CommentsViewDelegate {
    func addComment() {
        print("Added post")
    }
}

//MARK: - UICollectionViewDataSource
extension CommentsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = commentsView.commentCollectionView.dequeueReusableCell(withReuseIdentifier: CommentsCollectionViewCell.identifier, for: indexPath) as! CommentsCollectionViewCell
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension CommentsViewController: UICollectionViewDelegateFlowLayout {
    var sideInsertGor: CGFloat { return 20 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - sideInsertGor * 2)
        return CGSize(width: width, height: width)
    }
}
