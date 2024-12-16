//
//  UserViewModel.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 07.11.2024.
//

import Foundation

enum UserViewModelType {
    case login(UserViewModelDelegateLogin)
    case register(UserViewModelDelegateRegister)
}


protocol UserViewModelDelegateLogin: AnyObject {
    func didAuthenticate(succes: Bool)
}

protocol UserViewModelDelegateRegister: AnyObject {
    func didRegister(succes: Bool)
}

class UserViewModel {
    private let userModel = UserModel()
    private weak var delegateLogin: UserViewModelDelegateLogin?
    private weak var delegateReg: UserViewModelDelegateRegister?
    
    init(type: UserViewModelType) {
        switch type {
        case .login(let delegate):
            self.delegateLogin = delegate
        case .register(let delegate):
            self.delegateReg = delegate
        }
    }
    
    func login(userName: String, password: String) {
        let succes = userModel.loadPassword(for: userName) { truePassword in
            if let truePassword = truePassword,
               truePassword == password {
                self.delegateLogin?.didAuthenticate(succes: true)
            } else {
                self.delegateLogin?.didAuthenticate(succes: false)
            }
        }
    }
    
    func register(userName: String, password: String, againPassword: String) {
        // Тут можно добавить правила для логина и пароля
        if password.count >= 4 && password == againPassword {
            userModel.saveUser(name: userName, email: userName, password: password, tag: "@ksf", photo: nil)
            delegateReg?.didRegister(succes: true)
            return
        }
        delegateReg?.didRegister(succes: false)
    }
}
