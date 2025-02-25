//
//  NewPublicationViewController.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 08.11.2024.
//

import UIKit
import CoreData

var currentUserId: Int64?

class NewPublicationViewController: UIViewController {
    
    let coreDataManager: CoreDataManager = CoreDataManager.defaultConfig
    
    var coordinator: MainCoordinator?
    
    private lazy var newPublicationView = NewPublicationView(delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        coreDataManager.getAllPostsForUser(userId: currentUserId!) { posts in
            print(posts.count)
        }
    }
    
    private func setupView() {
        view = newPublicationView
        self.title = "Новый пост"
    }
}

//MARK: - NewPublicationViewDelegate
extension NewPublicationViewController: NewPublicationViewDelegate {
    
//    func addPost() {
//        guard let image = self.newPublicationView.selectedImageView.image else { return }
//        let imageData = image.jpegData(compressionQuality: 1.0)
//        coreDataManager.addPostToUser(userId: currentUserId!, postContent: imageData!) { succes in
//            if succes {
//                print("Post created successfully!")
//            } else {
//                print("Failed to create post.")
//            }
//        }
//        navigationController?.pushViewController(FeedViewController(), animated: true)
//    }
    
    func addPost() {
        coreDataManager.getCurrentUser { user in
            guard let image = self.newPublicationView.selectedImageView.image, let userId = user?.userId  else { return }
            let imageData = image.jpegData(compressionQuality: 1.0)
                        
            self.coreDataManager.addPostToUser(userId: userId, postContent: imageData!) { succes in
                if succes {
                    print("Post created successfully!")
                    DispatchQueue.main.async {
                        self.coordinator?.goToUpdatedFeed()
                    }
                } else {
                    print("Failed to create post.")
                }
            }
        }
    }
    
    @objc func addPicture() {
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
