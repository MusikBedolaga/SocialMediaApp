//
//  SettingsViewController.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 08.11.2024.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private lazy var settingsView = SettingsView(delegate: self)
    
    private var selectedPhotoCell: PhotoChangeTableViewCell?
    
    private var settings = [
        Setting(title: "Сменить фото", photo: UIImage(systemName: "photo.artframe")!, type: .photo),
        Setting(title: "Изменить имя", photo: UIImage(systemName: "pencil")!, type: .name),
        Setting(title: "Тема", photo: UIImage(systemName: "moonphase.first.quarter")!, type: .theme)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }
    
    private func setupController() {
        view = settingsView
        
        self.title = "Настройки"
        
        settingsView.setupTable(dataSource: self, delegate: self)
    }
}

//MARK: - SettingsViewDelegate
extension SettingsViewController: SettingsViewDelegate {
    func deleteUser() {
        print("delete")
    }
}

//MARK: - UITableViewDataSource
extension SettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let setting =  settings[indexPath.row]
        switch setting.type {
        case .photo:
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotoChangeTableViewCell.identifier,
                                                     for: indexPath) as! PhotoChangeTableViewCell
            cell.delegate = self
            return cell
        case .name:
            let cell = tableView.dequeueReusableCell(withIdentifier: NameChangeTableViewCell.identifier,
                                                     for: indexPath) as! NameChangeTableViewCell
            cell.delegate = self
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingSwitchTableViewCell.identifier,
                                                     for: indexPath) as! SettingSwitchTableViewCell
            cell.delegate = self
            return cell
        }
    }
}

//MARK: - UITableViewDelegate
extension SettingsViewController: UITableViewDelegate {}

//MARK: - NameChangeTableViewDelegate
extension SettingsViewController: TableViewCellDelegate {
    func changePhotoAction() {
        if let cell = selectedPhotoCell {
            if let image = cell.photoImageView.image {
                print("1")
                SettingsViewModel.changeUserPhoto(photo: image)
            }
        }
    }
    
    func didTapChangePhoto(_ cell: PhotoChangeTableViewCell) {
        selectedPhotoCell = cell
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    func switchChangedAction() {
        print("смена темы")
    }
    
    func changeName(_ cell: NameChangeTableViewCell) {
        SettingsViewModel.changeUserName(name: cell.nameTextField.text!)
        cell.nameTextField.text = ""
    }
}

//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let selectedImage = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
                selectedPhotoCell?.setupCell(image: selectedImage)
            }
        picker.dismiss(animated: true)
    }
}
