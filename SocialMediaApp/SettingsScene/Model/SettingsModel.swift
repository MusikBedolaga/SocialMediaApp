//
//  SettingsModel.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 05.03.2025.
//

import Foundation
import UIKit

enum SettingType {
    case photo
    case name
    case theme
}

struct Setting {
    let title: String
    let photo: UIImage
    let type: SettingType
}
