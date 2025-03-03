//
//  PersonalMessageViewModel.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 27.02.2025.
//

import Foundation
import CoreData


class PersonalMessageViewModel {
    
    public var currentUser: User?
    public var currentConversation: Conversation?
    
    var fetchController: NSFetchedResultsController<Messages>?
    
    init(delegate: NSFetchedResultsControllerDelegate, conversation: Conversation) {
        self.currentConversation = conversation
        
        CoreDataManager.defaultConfig.getCurrentUser { user in
            self.currentUser = user
            self.setupFetchController(delegate: delegate)
        }
    }
    
    private func setupFetchController(delegate: NSFetchedResultsControllerDelegate) {
        guard let currentConversation = currentConversation else { return }

        CoreDataManager.defaultConfig.getCurrentUser { [weak self] user in
            guard let self = self, let user = user else { return }
            self.currentUser = user

            let request = Messages.fetchRequest()
            request.predicate = NSPredicate(format: "(sender == %@ OR receiver == %@) AND conversation == %@", user, user, currentConversation.objectID)
            request.sortDescriptors = [NSSortDescriptor(key: "dateSent", ascending: true)]

            let frc = NSFetchedResultsController(fetchRequest: request,
                                                 managedObjectContext: CoreDataManager.defaultConfig.persistentContainer.viewContext,
                                                 sectionNameKeyPath: nil,
                                                 cacheName: nil)
            
            frc.delegate = delegate

            do {
                try frc.performFetch()
            } catch {
                print("Ошибка загрузки сообщений: \(error.localizedDescription)")
            }

            self.fetchController = frc
        }
    }
}
