//
//  PersonalMessageViewController.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 26.02.2025.
//

import UIKit
import CoreData

class PersonalMessageViewController: UIViewController {
    
    private lazy var personalMessageView = PersonalMessageView(delegate: self)
    
    private lazy var personalMessageViewModel = PersonalMessageViewModel(delegate: self)
    
    private lazy var frc = personalMessageViewModel.fetchController
    
    private let coreDataManager = CoreDataManager.defaultConfig
    
    public var currentConversation: Conversation?
    
    override func viewWillAppear(_ animated: Bool) {
        personalMessageView.personalMessageCollectionView.reloadData()
        personalMessageView.personalMessageCollectionView.layoutIfNeeded()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    private func setupView() {
        navigationItem.hidesBackButton = true
        view = personalMessageView
        personalMessageView.setupPersonalMessageCollection(delegate: self, dataSource: self)
    }
    
    private func getCurrentOutputText() -> String {
        let text = personalMessageView.outputMessageView.contentTextField.text!
        return text
    }
    
    func calculateHeightForText(_ text: String, width: CGFloat) -> CGFloat {
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.frame = CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude)
        label.sizeToFit()
        return label.frame.height
    }
}

//MARK: - OutputMessageViewDelegate
extension PersonalMessageViewController: OutputMessageViewDelegate {
    func pushMessage() {
        
        guard let conversation = currentConversation,
              let sender = personalMessageViewModel.currentUser,
              let receiver = (conversation.user1 == sender ? conversation.user2 : conversation.user1)
        else {
            print("Ошибка: не удалось определить участников чата")
            return
        }
        
        coreDataManager.addNewMessage(content: getCurrentOutputText(), conversation: conversation, sender: sender, receiver: receiver)
        
        DispatchQueue.main.async {
            self.personalMessageView.personalMessageCollectionView.reloadData()
        }
    }
}

//MARK: - UICollectionViewDataSource
extension PersonalMessageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        personalMessageViewModel.fetchController.fetchedObjects?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = personalMessageView.personalMessageCollectionView.dequeueReusableCell(withReuseIdentifier: PersonalMessageCollectionViewCell.identifier, for: indexPath) as! PersonalMessageCollectionViewCell
        
        let message = frc.object(at: indexPath)
        let isOutgoing = message.sender == personalMessageViewModel.currentUser
        cell.configure(with: message.content!, isOutgoing: isOutgoing)
        
        return cell
    }
}

//MARK: - UICollectionViewDataSource
extension PersonalMessageViewController: UICollectionViewDelegateFlowLayout {
    var sideInsert: CGFloat { return 5 }
    var sideBetween: CGFloat { return 3 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let message = frc.object(at: indexPath).content
        let maxWidth = collectionView.frame.width - 32
        let hight = calculateHeightForText(message!, width: maxWidth)
        
        return CGSize(width: collectionView.frame.width - 20, height: max(50, hight))
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sideBetween
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        UIEdgeInsets(top: sideBetween, left:  0, bottom: 0, right: sideBetween )
//        
//    }

}


extension PersonalMessageViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if view.window != nil {
            personalMessageView.personalMessageCollectionView.reloadData()
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if view.window != nil {
            personalMessageView.personalMessageCollectionView.reloadData()
        }
    }
}

