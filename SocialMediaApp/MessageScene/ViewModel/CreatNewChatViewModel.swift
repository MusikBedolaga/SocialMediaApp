//
//  CreatNewChatViewModel.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 02.03.2025.
//

import Foundation
import CoreData



class CreatNewChatViewModel {
    
    private let coreDataManager = CoreDataManager.defaultConfig
    public var fetchController: NSFetchedResultsController<User>?
    private var delegate: NSFetchedResultsControllerDelegate?
    
    init(delegate: NSFetchedResultsControllerDelegate) {
        self.delegate = delegate
        loadCurrentUser()
    }
    
    private func loadCurrentUser() {
        coreDataManager.getCurrentUser { user in
            guard let user = user else { return }
            
            let request = User.fetchRequest()
            request.predicate = NSPredicate(format: "SELF != %@ AND email != %@", user, user.email ?? "")
            request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
            
            let frc = NSFetchedResultsController(fetchRequest: request,
                                                 managedObjectContext: self.coreDataManager.persistentContainer.viewContext,
                                                 sectionNameKeyPath: nil,
                                                 cacheName: nil)
            frc.delegate = self.delegate
            do {
                try frc.performFetch()
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name("NewChatDataUpdated"), object: nil)
                }
            } catch {
                print("Ошибка загрузки пользователей: \(error.localizedDescription)")
            }
            
            self.fetchController = frc
        }
    }
    
    func getFetchedResultsController() -> NSFetchedResultsController<User>? {
        return fetchController
    }
}
