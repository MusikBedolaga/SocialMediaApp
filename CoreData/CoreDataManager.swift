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
    
    func setCurrentUser(user: User) {
        UserDefaults.standard.set(user.userId, forKey: "currentUserId")
    }
    
    func getCurrentUser(completion: @escaping (User?) -> Void) {
        let context = persistentContainer.viewContext
        if let userId = UserDefaults.standard.value(forKey: "currentUserId") as? Int64 {
            getUserForId(userId: userId, context: context, completion: completion)
        } else {
            completion(nil)
        }
    }

    
    func addUser(newUser: User) {
        persistentContainer.performBackgroundTask { context in
            let user = User(context: context)
            user.name = newUser.name
            user.tag = newUser.tag
            user.photo = newUser.photo
            user.userId = Int64(arc4random())
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
    
    func getUserForEmail(email: String, completion: @escaping (User?) -> Void) {
        persistentContainer.performBackgroundTask { context in
            let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "email == %@", email)

            do {
                let result = try context.fetch(fetchRequest)
                if let user = result.first {
                    completion(user)
                } else {
                    completion(nil)
                }
            } catch {
                print("Failed to fetch user: $error.localizedDescription)")
                completion(nil)
            }
        }
    }
    
    private func getUserForId(userId: Int64, context: NSManagedObjectContext, completion: @escaping (User?) -> Void) {

        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()

        fetchRequest.predicate = NSPredicate(format: "userId == %lld", userId)

        do {

            let result = try context.fetch(fetchRequest)

            completion(result.first)

        } catch {

            print("Failed to fetch user: $error.localizedDescription)")

            completion(nil)

        }

    }
    
    //MARK: - Post
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
    
    func addPostToUser(userId: Int64, postContent: Data, completion: @escaping (Bool) -> Void) {
        persistentContainer.performBackgroundTask { context in
            self.getUserForId(userId: userId, context: context) { user in
                guard let user = user else {
                    completion(false)
                    return
                }

                let post = Post(context: context)
                post.content = postContent
                post.id = Int64(arc4random())
                post.likes = "0"
                post.countComments = "0"
                post.user = user

                do {
                    try context.save()
                    completion(true)
                } catch {
                    print("Ошибка при добавлении поста: $error.localizedDescription)")
                    completion(false)
                }
            }
        }
    }
    
    func getAllPostsForUser(userId: Int64, completion: @escaping ([Post]) -> Void) {
            persistentContainer.performBackgroundTask { context in
                let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "user.userId == %lld", userId) // Здесь предполагается, что в сущности Post есть связь с User

                do {
                    let posts = try context.fetch(fetchRequest)
                    completion(posts)
                } catch {
                    print("Ошибка при извлечении постов: $error.localizedDescription)")
                    completion([])
                }
            }
        }
}
