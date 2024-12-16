//
//  LoginViewController.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 03.11.2024.
//

import UIKit

class LoginViewController: UIViewController {

    var coordinator: AuthCoordinator?
    
    private lazy var loginView: LoginView = LoginView(delegate: self)
    
    private lazy var userViewModel = UserViewModel(type: .login(self))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = loginView
    }
    
    private func getUserName() -> String {
        return loginView.emailTF.text ?? ""
    }
    
    private func getPassword() -> String {
        return loginView.passwordTF.text ?? ""
    }

}

//MARK: - LoginViewDelegate
extension LoginViewController: LoginViewDelegate {
    func signIn() {
        userViewModel.login(userName: getUserName(), password: getPassword())
    }
    
    func signUp() {
        coordinator?.showRegisterScene()
    }
}


//MARK: - UserViewModelDelegate
extension LoginViewController: UserViewModelDelegateLogin {
    func didAuthenticate(succes: Bool) {
        if succes {
            coordinator?.showMainScene()
        }
        else {
            let okAlert = UIAlertController(title: "Ошибка", message: "Неправильный логин или пароль", preferredStyle: .alert)
            okAlert.addAction(UIAlertAction(title: "ОК", style: .destructive))
            present(okAlert, animated: true)
        }
    }
}
