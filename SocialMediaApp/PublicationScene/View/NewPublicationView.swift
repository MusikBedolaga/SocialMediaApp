//
//  NewPublicationView.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 09.12.2024.
//

import UIKit

protocol NewPublicationViewDelegate: AnyObject {
    func addPost()
    func addPicture()
    func clearContent()
}

class NewPublicationView: UIView {
    
    private weak var delegate: NewPublicationViewDelegate?

    private let addPostButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .customRed
        button.setTitle("Создать пост", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(addPost), for: .touchUpInside)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        return button
    }()
    
    private let addPictureButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .customRed
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(addPicture), for: .touchUpInside)
        button.tintColor = .white
        return button
    }()
    
    private let clearContentButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .customRed
        button.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(clearContent), for: .touchUpInside)
        button.tintColor = .white
        return button
    }()
    
    public let selectedImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    init(delegate: NewPublicationViewDelegate) {
        super.init(frame: .zero)
        self.delegate = delegate
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        
        backgroundColor = .white
        
        [addPictureButton, clearContentButton, selectedImageView, addPostButton].forEach({ addSubview($0) })
        
        //MARK: addPictureButton
        NSLayoutConstraint.activate([
            addPictureButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            addPictureButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            addPictureButton.widthAnchor.constraint(equalToConstant: 40),
            addPictureButton.heightAnchor.constraint(equalTo: addPictureButton.widthAnchor)
        ])
        
        //MARK: clearContentButton
        NSLayoutConstraint.activate([
            clearContentButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            clearContentButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            clearContentButton.widthAnchor.constraint(equalToConstant: 40),
            clearContentButton.heightAnchor.constraint(equalTo: clearContentButton.widthAnchor)
        ])
        
        //MARK: selectedImageView
        NSLayoutConstraint.activate([
            selectedImageView.topAnchor.constraint(equalTo: addPictureButton.bottomAnchor, constant: 10),
            selectedImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            selectedImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            selectedImageView.bottomAnchor.constraint(equalTo: addPostButton.topAnchor, constant: -10)
        ])
        
        //MARK: addToPostButton
        NSLayoutConstraint.activate([
            addPostButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            addPostButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            addPostButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        
    }
    
    @objc private func addPost() {
        delegate?.addPost()
    }
    
    @objc private func addPicture() {
        delegate?.addPicture()
    }
    
    @objc private func clearContent() {
        delegate?.clearContent()
    }
}
