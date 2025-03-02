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
    
    lazy var fetchController: NSFetchedResultsController<Messages> = {
        let requst = Messages.fetchRequest()
        
        requst.predicate = NSPredicate(format: "sender == %@ OR receiver == %@", currentUser!, currentUser!)
        
        requst.sortDescriptors = [NSSortDescriptor(key: "dateSent", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: requst,
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
