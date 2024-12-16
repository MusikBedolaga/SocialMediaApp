//
//  CoreDataManager.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 13.12.2024.
//

import Foundation
import CoreData


class CoreDataManager {
    
    static let defaultConfig = CoreDataManager()
    
    private init() { }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "SocialMediaApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    //MARK: - User
    func addUser(newUser: User) {
        persistentContainer.performBackgroundTask { context in
            let user = User(context: context)
            user.name = newUser.name
            user.tag = newUser.tag
            user.photo = newUser.photo
            user.userId = newUser.userId
            user.email = newUser.email
            user.posts = newUser.posts
            do {
                try context.save()
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteUser(delUser: User) {
        persistentContainer.performBackgroundTask { context in
            context.delete(delUser)
            do {
                try context.save()
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func existsUser(email: String, completion: @escaping (Bool) -> Void) {
        persistentContainer.performBackgroundTask { context in
            let fetchRequst: NSFetchRequest<User> = User.fetchRequest()
            fetchRequst.predicate = NSPredicate(format: "email == %@", email)
            do {
                let result = try context.fetch(fetchRequst)
                completion(!result.isEmpty)
            } catch {
                completion(false)
            }
        }
    }
    
    
    //MARK: - Post
    func addPost(newPost: Post) {
        persistentContainer.performBackgroundTask { context in
            let post = Post(context: context)
            post.likes = "\(0)"
            post.countComments = "\(0)"
            post.content = newPost.content
            post.id = newPost.id
            post.user = newPost.user
            do {
                try context.save()
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func deletePost(delPost: Post) {
        persistentContainer.performBackgroundTask { context in
            context.delete(delPost)
            do {
                try context.save()
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func existsPost(id: Int64, completion: @escaping (Bool) -> Void) {
        persistentContainer.performBackgroundTask { context in
            let fetchRequst: NSFetchRequest<Post> = Post.fetchRequest()
            fetchRequst.predicate = NSPredicate(format: "id == %@" , id)
            do {
                let result = try context.fetch(fetchRequst)
                completion(!result.isEmpty)
            } catch {
                completion(false)
            }
        }
    }
}
