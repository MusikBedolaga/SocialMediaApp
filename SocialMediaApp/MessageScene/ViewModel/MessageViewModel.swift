//
//  MessageViewModel.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 03.03.2025.
//

import Foundation
import CoreData

class MessagesViewModel {
    
    public var currentUser: User?
    
    lazy var fetchController: NSFetchedResultsController<Conversation> = {
        let request = Conversation.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        
        if let user = currentUser {
            request.predicate = NSPredicate(format: "(user1 == %@ OR user2 == %@) AND user1 != user2", user, user)
        }
        
        let frc = NSFetchedResultsController(fetchRequest: request,
                                             managedObjectContext: CoreDataManager.defaultConfig.persistentContainer.viewContext,
                                             sectionNameKeyPath: nil,
                                             cacheName: nil)
        
        do {
            try frc.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        
        return frc
    }()
    
    init(delegate: NSFetchedResultsControllerDelegate) {
        CoreDataManager.defaultConfig.getCurrentUser { user in
            self.currentUser = user
            self.fetchController.delegate = delegate
            try? self.fetchController.performFetch()
        }
    }
}
