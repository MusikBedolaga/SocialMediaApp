//
//  AuthModel.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 07.11.2024.
//

import Foundation
import Security
import CoreData

class KeychainService {
    
    static func save(key: String, data: Data) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        SecItemDelete(query as CFDictionary)
        return SecItemAdd(query as CFDictionary, nil) == errSecSuccess
    }
    
    static func load(key: String) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess else { return nil }
        return item as? Data
    }
    
    static func delete(key: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        return SecItemDelete(query as CFDictionary) == errSecSuccess
    }
}

class UserModel {
    
    private let coreDataManager = CoreDataManager.defaultConfig
    
    init() { }
    
    func saveUser(
        name: String,
        email: String,
        password: String,
        tag: String,
        photo: Data?
    ) {
        coreDataManager.existsUser(email: email) { exists in
            if exists {
                print("Такой юзер уже есть") // вернуть колбэк
                return
            }
            
            if let passwordData = password.data(using: .utf8) {
                let success = KeychainService.save(key: email, data: passwordData)
                if success {
                    let newUser = User(context: self.coreDataManager.persistentContainer.viewContext)
                    newUser.name = name
                    newUser.email = email
                    newUser.tag = tag
                    self.coreDataManager.addUser(newUser: newUser)
                }
                else {
                    print("Неудалось сохранить в Keychain") // вернуть колбэк
                }
            }
        }
    }
    
    func loadPassword(for userEmail: String, completion: @escaping (String?) -> Void) {
        coreDataManager.existsUser(email: userEmail) { exists in
            if !exists {
                DispatchQueue.main.async {
                    print("User with email \(userEmail) does not exist.")
                    completion(nil)
                }
                return
            }

            if let passwordData = KeychainService.load(key: userEmail) {
                let password = String(data: passwordData, encoding: .utf8)
                DispatchQueue.main.async {
                    completion(password)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    func deleteUser(email: String) {
        coreDataManager.existsUser(email: email) { exists in
            if exists {
                let context = self.coreDataManager.persistentContainer.viewContext
                let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "email == %@", email)
                    
                do {
                    let users = try context.fetch(fetchRequest)
                    for user in users {
                        self.coreDataManager.deleteUser(delUser: user)
                        KeychainService.delete(key: email)
                    }
                } catch {
                    print("Error fetching user for deletion: \(error.localizedDescription)")
                }
            } else {
                print("User with email \(email) does not exist.")
            }
        }
    }
}
