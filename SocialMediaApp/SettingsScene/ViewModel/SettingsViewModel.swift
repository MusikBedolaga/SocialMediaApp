//
//  SettingsViewModel.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 05.03.2025.
//

import Foundation
import UIKit
import CoreData

class SettingsViewModel {
    
    static let coreDataManager = CoreDataManager.defaultConfig
    
    static func changeUserName(name: String) {
        coreDataManager.getCurrentUser { user in
            DispatchQueue.main.async {
                user?.name = name
                coreDataManager.saveContext()
            }
        }
    }
    
    static func changeUserPhoto(photo: UIImage) {
        coreDataManager.getCurrentUser { user in
            if let imageData = photo.jpegData(compressionQuality: 0.8) {
                DispatchQueue.main.async {
                    user?.photo = imageData
                    coreDataManager.saveContext()
                }
            }
        }
    }
}
