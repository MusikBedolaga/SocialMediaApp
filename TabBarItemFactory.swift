//
//  TabBarItemFactory.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 08.11.2024.
//

import Foundation
import UIKit

class TabBarItemFactory {
    static func createTabBarItem(title: String, systemNameImg: String, tag: Int) ->  UITabBarItem {
        let tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: systemNameImg), tag: tag)
        return tabBarItem
    }
}
