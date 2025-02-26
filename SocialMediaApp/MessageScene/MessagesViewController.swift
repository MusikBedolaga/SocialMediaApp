//
//  MessagesViewController.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 08.11.2024.
//

import UIKit

class MessagesViewController: UIViewController {
    
    private let messageView = MessageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        
        view = messageView
        
        messageView.setupMessageCollection(delegate: self, dataSource: self)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: messageView.titleMessage)
        
    }
}


//MARK: - UICollectionViewDelegateFlowLayout
extension MessagesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = collectionView.bounds.height / 8
        return CGSize(width: width, height: height)
    }
}


//MARK: - UICollectionViewDataSource
extension MessagesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageCollectionViewCell.identifier, for: indexPath) as! MessageCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let personalMessageVC = PersonalMessageViewController()
        navigationController?.pushViewController(personalMessageVC, animated: true)
    }
    
}
