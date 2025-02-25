//
//  MainCoordinator.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 03.11.2024.
//

import Foundation
import UIKit

class MainCoordinator {
    
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = UITabBarController()
    }
    
    func start() {
        setupTabBar()
        navigationController.setViewControllers([tabBarController], animated: true)
    }
    
    func goToComments() {
        let commentsVC = CommentsViewController()
        navigationController.present(commentsVC, animated: true)
    }
    
    func goToUpdatedFeed() {
        tabBarController.selectedIndex = 0
            
        if let navigationController = tabBarController.viewControllers?.first as? UINavigationController {
        let newFeedVC = FeedViewController()
            navigationController.setViewControllers([newFeedVC], animated: true)
        }
    }
    
    
    private func setupTabBar() {
        
        let feedVC = FeedViewController()
        let feedNavController = UINavigationController(rootViewController: feedVC)
        feedNavController.tabBarItem = TabBarItemFactory.createTabBarItem(title: "Лента", systemNameImg: "house", tag: 0)
        
        let messagesVC = MessagesViewController()
        let messagesNavController = UINavigationController(rootViewController: messagesVC)
        messagesNavController.tabBarItem = TabBarItemFactory.createTabBarItem(title: "Сообщения", systemNameImg: "message", tag: 1)
        
        let newPublicationVC = NewPublicationViewController()
        let newPublicationNavController = UINavigationController(rootViewController: newPublicationVC)
        newPublicationVC.coordinator = self
        newPublicationNavController.tabBarItem = TabBarItemFactory.createTabBarItem(title: "Новый пост", systemNameImg: "plus", tag: 2)
        
        let profileVC = ProfileViewController()
        let profileNavController = UINavigationController(rootViewController: profileVC)
        profileNavController.tabBarItem = TabBarItemFactory.createTabBarItem(title: "Профиль", systemNameImg: "person.crop.circle.fill", tag: 3)
        
        let settingsVC = SettingsViewController()
        let settingsNavController = UINavigationController(rootViewController: settingsVC)
        settingsNavController.tabBarItem = TabBarItemFactory.createTabBarItem(title: "Настройки", systemNameImg: "gearshape", tag: 4)
        
        tabBarController.tabBar.backgroundColor = .customRed
        tabBarController.tabBar.tintColor = .white
        tabBarController.tabBar.unselectedItemTintColor = .lightGray
        tabBarController.viewControllers = [feedNavController, messagesNavController, newPublicationNavController, profileNavController, settingsNavController]
    }
}
