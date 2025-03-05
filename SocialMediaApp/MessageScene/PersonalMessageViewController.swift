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
    
    private lazy var personalMessageViewModel = PersonalMessageViewModel(delegate: self, conversation: currentConversation!)
    
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
        
        guard let conversation = currentConversation else { return }
        let receiver = conversation.user1 == personalMessageViewModel.currentUser ? conversation.user2 : conversation.user1
        personalMessageView.setupIndorationView(userImage: nil, userName: receiver?.name)
    }
    
    private func getCurrentOutputText() -> String {
        let text = personalMessageView.outputMessageView.contentTextField.text!
        return text
    }
    
    private func scrollToLastMessage() {
        guard let messages = frc?.fetchedObjects, !messages.isEmpty else { return }
        let lastIndexPath = IndexPath(item: messages.count - 1, section: 0)
        
        personalMessageView.personalMessageCollectionView.scrollToItem(at: lastIndexPath, at: .bottom, animated: true)
    }
    
    private func calculateHeightForText(_ text: String, width: CGFloat) -> CGFloat {
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
extension PersonalMessageViewController: PersonalMessageDelegate {
    func pushMessage() {
        guard let conversation = currentConversation,
              let sender = personalMessageViewModel.currentUser,
              let receiver = (conversation.user1 == sender ? conversation.user2 : conversation.user1)
        else {
            print("Ошибка: не удалось определить участников чата")
            return
        }

        coreDataManager.addNewMessage(content: getCurrentOutputText(), conversation: conversation, sender: sender, receiver: receiver)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                do {
                    try self.frc?.performFetch()
                    print("🔄 Принудительный performFetch() выполнен, найдено \(self.frc?.fetchedObjects?.count ?? 0) сообщений")
                    self.personalMessageView.personalMessageCollectionView.reloadData()
                } catch {
                    print("❌ Ошибка загрузки сообщений: \(error.localizedDescription)")
                }
            }
        
        self.personalMessageView.outputMessageView.contentTextField.text = ""
        
        coreDataManager.saveContext()
    }
    
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - UICollectionViewDataSource
extension PersonalMessageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        personalMessageViewModel.fetchController?.fetchedObjects?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = personalMessageView.personalMessageCollectionView.dequeueReusableCell(withReuseIdentifier: PersonalMessageCollectionViewCell.identifier, for: indexPath) as! PersonalMessageCollectionViewCell
        
        guard let message = frc?.object(at: indexPath) else { return cell}
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
        
        let message = frc?.object(at: indexPath).content
        let maxWidth = collectionView.frame.width - 32
        let hight = calculateHeightForText(message!, width: maxWidth)
        
        return CGSize(width: collectionView.frame.width - 20, height: max(50, hight))
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sideBetween
    }
}


extension PersonalMessageViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        // Убираем лишние обновления, просто обновляем коллекцию
        personalMessageView.personalMessageCollectionView.performBatchUpdates(nil, completion: nil)
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        guard let messages = frc?.fetchedObjects, !messages.isEmpty else { return }
        
        let lastIndex = messages.count - 1
        let indexPath = IndexPath(item: lastIndex, section: 0)
        
        DispatchQueue.main.async {
            // Проверка, что данные в коллекции действительно изменились
            let currentCount = self.personalMessageView.personalMessageCollectionView.numberOfItems(inSection: 0)
            
            // Если количество элементов в коллекции увеличилось (т.е. был добавлен новый элемент)
            if currentCount < messages.count {
                // Вставляем новый элемент, если индекс правильный
                self.personalMessageView.personalMessageCollectionView.performBatchUpdates({
                    self.personalMessageView.personalMessageCollectionView.insertItems(at: [indexPath])
                }, completion: { _ in
                    // Прокручиваем к последнему сообщению
                    self.scrollToLastMessage()
                })
            } else {
                // В противном случае просто перезагружаем всю коллекцию
                self.personalMessageView.personalMessageCollectionView.reloadData()
                print("Перезагружена коллекция, изменений не было.")
            }
        }
    }
}

