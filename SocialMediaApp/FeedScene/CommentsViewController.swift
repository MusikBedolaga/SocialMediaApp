//
//  CommentsViewController.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 02.12.2024.
//

import UIKit
import CoreData

class CommentsViewController: UIViewController {

    private lazy var commentsView = CommentsView(delegate: self)
    
    private var commentsViewModel: CommetnsViewModel?
    
    public var currentPost: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view = commentsView
        
        if let post = currentPost {
            commentsViewModel = CommetnsViewModel(delegate: self, currentPost: post)
        }
        
        commentsView.setupTextView(delegate: self)
        
        commentsView.setupCollection(dataSource: self, delegate: self)
    }
}

//MARK: - UITextViewDelegate
extension CommentsViewController: UITextViewDelegate { }

//MARK: - CommentsViewDelegate
extension CommentsViewController: CommentsViewDelegate {
    func addComment() {
        if let content  = commentsView.createComment.text,
           let post = currentPost {
            commentsViewModel?.createNewCommet(content: content, post: post)
        }
        commentsView.createComment.text = ""
    }
}

//MARK: - UICollectionViewDataSource
extension CommentsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        commentsViewModel?.frc?.fetchedObjects?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = commentsView.commentCollectionView.dequeueReusableCell(withReuseIdentifier: CommentsCollectionViewCell.identifier, for: indexPath) as! CommentsCollectionViewCell
        
        if let comment = commentsViewModel?.frc?.object(at: indexPath),
           let user = comment.user {
            cell.setupCell(image: user.photo,
                           name: user.name!,
                           content: comment.content ?? "",
                           countLike: comment.countLike)
        }
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension CommentsViewController: UICollectionViewDelegateFlowLayout {
//    var sideInsertGor: CGFloat { return 20 }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = (collectionView.bounds.width - sideInsertGor * 2)
//        return CGSize(width: width, height: width)
//    }
}


//MARK: - NSFetchedResultsControllerDelegate
extension CommentsViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        commentsView.commentCollectionView.reloadData()
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        commentsView.commentCollectionView.reloadData()
    }
}
