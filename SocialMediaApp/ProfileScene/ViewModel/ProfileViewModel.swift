//
//  ProfileViewModel.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 05.03.2025.
//

import Foundation
import CoreData

class ProfileViewModel {
    public var currentUser: User?
    public var frc: NSFetchedResultsController<Post>?
    
    private let coreDataManager = CoreDataManager.defaultConfig
    
    init(delegate: NSFetchedResultsControllerDelegate) {
        coreDataManager.getCurrentUser { user in
            self.currentUser = user
            self.setupFrc(delegate: delegate)
        }
    }
    
    private func setupFrc(delegate: NSFetchedResultsControllerDelegate) {
        coreDataManager.getCurrentUser { [weak self] user in
            guard let self = self, let user = user else { return }
            self.currentUser = user

            let request = Post.fetchRequest()
            request.predicate = NSPredicate(format: "user = %@", user)
            request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]

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

            self.frc = frc
        }
    }
}
