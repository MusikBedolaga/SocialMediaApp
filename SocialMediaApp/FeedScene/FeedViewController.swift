//
//  FeedViewController.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 05.11.2024.
//

import UIKit
import CoreData

class FeedViewController: UIViewController {
    
    private lazy var feedView = FeedView()
    
    var coordinator: UINavigationController?
    
    private lazy var feedViewModel = FeedViewModel(delegate: self)
    
    private lazy var frc = feedViewModel.fetchResultController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        feedView.postCollection.reloadData()
    }
    
    private func setupView() {
        
        view = feedView
        
        self.title = "Лента"
        
        feedView.setupPostCollectionView(delegate: self, dataSource: self)
        feedView.setupHistoryCollectionView(delegate: self, dataSource: self)
        
        feedView.addPostButton.addTarget(self, action: #selector(addPost), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: feedView.addPostButton)
        
        feedView.notificationsButton.addTarget(self, action: #selector(checkNotifications), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: feedView.notificationsButton)
    }
    
    @objc private func addPost() {
        print("addPost")
    }
    
    @objc private func checkNotifications() {
        print("checkNotifications")
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension FeedViewController: UICollectionViewDelegateFlowLayout {
    var sideInsert: CGFloat { return 16 }
    var sideInsertGor: CGFloat { return 20 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == feedView.historyCollection {
            let width = (collectionView.bounds.width - sideInsert * 5) / 4
            return CGSize(width: width, height: width)
        } else {
            let width = (collectionView.bounds.width - sideInsertGor * 2)
            return CGSize(width: width, height: width)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == feedView.historyCollection {
            sideInsert - 6
        } else {
            sideInsert
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sideInsert
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == feedView.historyCollection {
            UIEdgeInsets(top: sideInsert - 6, left: sideInsert - 6, bottom: sideInsert - 6, right: sideInsert - 6)
        } else {
            UIEdgeInsets(top: sideInsert, left: sideInsert, bottom: sideInsert, right: sideInsert)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == feedView.postCollection {
            let commentsVC = CommentsViewController()
            present(commentsVC, animated: true)
        }
    }
}

//MARK: - UICollectionViewDataSource
extension FeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == feedView.historyCollection {
            return 7
        } else {
            return frc.fetchedObjects?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == feedView.historyCollection {
            let cell = feedView.historyCollection.dequeueReusableCell(withReuseIdentifier: HistoryCollectionViewCell.identifier, for: indexPath) as! HistoryCollectionViewCell
            cell.backgroundColor = .clear
            return cell
        } else {
            let cell = feedView.postCollection.dequeueReusableCell(withReuseIdentifier: PostlCollectionViewCell.identifier, for: indexPath) as! PostlCollectionViewCell
            cell.setupCell(post: frc.object(at: indexPath))
            cell.backgroundColor = .clear
            return cell
        }
    }
}


//MARK: - NSFetchedResultsControllerDelegate
extension FeedViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        feedView.historyCollection.reloadData()
        feedView.postCollection.reloadData()
        }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        feedView.historyCollection.reloadData()
        feedView.postCollection.reloadData()
    }
}
