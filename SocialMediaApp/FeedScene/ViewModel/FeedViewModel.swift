//
//  FeedViewModel.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 15.12.2024.
//

import Foundation
import CoreData

class FeedViewModel {
    static let fetchResultController: NSFetchedResultsController<Post> = {
        let request = Post.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "likes", ascending: false)]
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.defaultConfig.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try frc.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        return frc
    }()
}
