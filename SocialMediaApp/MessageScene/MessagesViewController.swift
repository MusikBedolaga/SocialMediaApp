//
//  MessagesViewController.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 08.11.2024.
//

import UIKit
import CoreData

class MessagesViewController: UIViewController {
    
    private lazy var messageViewModel = MessagesViewModel(delegate: self)
    
    private lazy var frc = messageViewModel.fetchController
    
    private let messageView = MessageView()
    
    override func viewWillAppear(_ animated: Bool) {
        messageView.messageCollection.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        
        view = messageView
        
        messageView.setupMessageCollection(delegate: self, dataSource: self)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: messageView.titleMessage)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "sparkle.magnifyingglass"), style: .plain, target: self, action: #selector(addChat))
        
    }
    
    @objc private func addChat() {
        let createNewChatVC = CreateNewChatTableViewController()
        createNewChatVC.delegate = self
        present(createNewChatVC, animated: true)
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
        frc.fetchedObjects?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageCollectionViewCell.identifier, for: indexPath) as! MessageCollectionViewCell
        
        let conversation = frc.object(at: indexPath)
        
        let currentUser = messageViewModel.currentUser
        let chatPartner = (conversation.user1 == currentUser) ? conversation.user2 : conversation.user1
        
        if let partnerName = chatPartner?.name {
            let partnerImage: Data? = chatPartner?.photo
            cell.setupCell(userImage: partnerImage, userName: partnerName)
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let personalMessageVC = PersonalMessageViewController()
            personalMessageVC.currentConversation = self.frc.object(at: indexPath)
            self.navigationController?.pushViewController(personalMessageVC, animated: true)
        }
    }
}

//MARK: - UICollectionViewDelegate
extension MessagesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, trailingSwipeActionsConfigurationForItemAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        print("Trailing swipe action triggered")
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { _ , _, completionHandler in
            let conversation = self.frc.object(at: indexPath)
            self.messageViewModel.deleteConversation(conversation: conversation)
            completionHandler(true)
        }

        deleteAction.backgroundColor = UIColor.red
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func collectionView(_ collectionView: UICollectionView, leadingSwipeActionsConfigurationForItemAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        print("Leading swipe action triggered")
        let pinAction = UIContextualAction(style: .normal, title: "Закрепить") { _, _, completionHandler in
            print("Чат закреплён")
            completionHandler(true)
        }
        
        pinAction.backgroundColor = UIColor.systemBlue // Синий цвет для закрепления

        return UISwipeActionsConfiguration(actions: [pinAction])
    }
}

//MARK: - NSFetchedResultsControllerDelegate
extension MessagesViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        messageView.messageCollection.reloadData()
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        messageView.messageCollection.reloadData()
    }
}

//MARK: - CreateNewChatDelegate
extension MessagesViewController: CreateNewChatDelegate {
    func didCreateNewChat() {
        frc = messageViewModel.fetchController
        messageView.messageCollection.reloadData()
    }
}
