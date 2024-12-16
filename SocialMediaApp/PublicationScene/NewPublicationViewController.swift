//
//  NewPublicationViewController.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 08.11.2024.
//

import UIKit
import CoreData

class NewPublicationViewController: UIViewController {
    
    let coreDataManager: CoreDataManager = CoreDataManager.defaultConfig
    
    private lazy var newPublicationView = NewPublicationView(delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view = newPublicationView
        self.title = "Новый пост"
    }
}

//MARK: - NewPublicationViewDelegate
extension NewPublicationViewController: NewPublicationViewDelegate {
    func addPost() {
        print("add")
        if let image = self.newPublicationView.selectedImageView.image {
            let newPost = Post()
            newPost.content = image.jpegData(compressionQuality: 1.0)
            self.coreDataManager.addPost(newPost: newPost)
        }
    }
    
    func addPicture() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func clearContent() {
        newPublicationView.selectedImageView.image = nil
    }
}

//MARK: - UIImagePickerControllerDelegate
extension NewPublicationViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[.editedImage] as? UIImage {
            newPublicationView.selectedImageView.image = selectedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            newPublicationView.selectedImageView.image = originalImage
        }
        picker.dismiss(animated: true, completion: nil)
        }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
    }
}

//MARK: - UINavigationControllerDelegate
extension NewPublicationViewController: UINavigationControllerDelegate { }
