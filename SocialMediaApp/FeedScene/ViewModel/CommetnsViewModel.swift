//
//  CommetnsViewModel.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 08.03.2025.
//

import Foundation
import CoreData

class CommetnsViewModel {
    
    public var frc: NSFetchedResultsController<Comments>?
    
    init(delegate: NSFetchedResultsControllerDelegate, currentPost: Post) {
        frc = setupFrc(delegate: delegate, currentPost: currentPost)
    }
    
    private func setupFrc(delegate: NSFetchedResultsControllerDelegate, currentPost: Post) -> NSFetchedResultsController<Comments> {
        
        let request = Comments.fetchRequest()
        request.predicate = NSPredicate(format: "post == %@", currentPost)
        request.sortDescriptors = [NSSortDescriptor(key: "createAt", ascending: false)]
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.defaultConfig.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try frc.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        
        frc.delegate = delegate
        
        return frc
    }
    
    public func createNewCommet(content: String, post: Post) {
        CoreDataManager.defaultConfig.getCurrentUser { user in
            if let user = user {
                CoreDataManager.defaultConfig.addNewComment(content: content, post: post, user: user)
            }
        }
    }
}
