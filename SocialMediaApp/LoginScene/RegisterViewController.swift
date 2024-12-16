//
//  RegisterViewController.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 04.11.2024.
//

import UIKit

class RegisterViewController: UIViewController {
    
    var coordinator: AuthCoordinator?
    
    private lazy var registerView = RegisterView(delegate: self)
    private lazy var userViewModel = UserViewModel(type: .register(self))

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    private func layout() {
        view = registerView
    }
    
    private func getUserName() -> String {
        return  registerView.emailTF.text ?? ""
    }
    
    private func getPassword() -> String {
        return registerView.passwordTF.text ?? ""
    }
    
    private func getRepeatPassword() -> String {
        return registerView.repeatPasswordTF.text ?? ""
    }
}


//MARK: - RegisterViewDelegate
extension RegisterViewController: RegisterViewDelegate {
    func selectPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func createNewUser() {
        userViewModel.register(userName: getUserName(), password: getPassword(), againPassword: getRepeatPassword())
    }
    
}

//MARK: - UIImagePickerControllerDelegate
extension RegisterViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let selectedImage = info[.editedImage] as? UIImage {
                registerView.selectPhotoButton.imageView.image = selectedImage
            } else if let originalImage = info[.originalImage] as? UIImage {
                registerView.selectPhotoButton.imageView.image = originalImage
            }
            picker.dismiss(animated: true, completion: nil)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
}

//MARK: - UINavigationControllerDelegate
extension RegisterViewController: UINavigationControllerDelegate { }

//MARK: - UserViewModelDelegateRegister
extension RegisterViewController: UserViewModelDelegateRegister {
    func didRegister(succes: Bool) {
        if succes {
            coordinator?.start()
        }
        else {
            let okAlert = UIAlertController(title: "Ошибка", message: "Неправильно веден логин или пароль", preferredStyle: .alert)
            okAlert.addAction(UIAlertAction(title: "ОК", style: .destructive))
            present(okAlert, animated: true)
        }
    }
}
