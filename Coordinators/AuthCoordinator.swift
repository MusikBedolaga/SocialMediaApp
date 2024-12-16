//
//  AuthCoordinator.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 03.11.2024.
//

import Foundation
import UIKit

class AuthCoordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginVC = LoginViewController()
        loginVC.coordinator = self
        navigationController.pushViewController(loginVC, animated: false)
    }
    
    func showMainScene() {
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        mainCoordinator.start()
    }
    
    func showRegisterScene() {
        let registerVC = RegisterViewController()
        registerVC.coordinator = self
        navigationController.setViewControllers([registerVC], animated: true)
    }
}
