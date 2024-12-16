//
//  RegisterView.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 05.11.2024.
//

import UIKit

protocol ImageViewPikerDelegate: AnyObject {
    func selectPhoto()
}

class ImageViewPiker: UIView {
    
    private weak var delegate: ImageViewPikerDelegate?
    
    private let selectImageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Select photo", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .customRed
        button.addTarget(self, action: #selector(selectPhoto), for: .touchUpInside)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 10
        return button
    }()
    
    public let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 2
        imageView.backgroundColor = .customRed
        return imageView
    }()
    
    init(delegate: ImageViewPikerDelegate) {
        super.init(frame: .zero)
        self.delegate = delegate
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        
        addSubview(selectImageButton)
        addSubview(imageView)
        
        //MARK: selectImageButton
        NSLayoutConstraint.activate([
            selectImageButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            selectImageButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            selectImageButton.widthAnchor.constraint(equalToConstant: 120),
            selectImageButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        //MARK: imageView
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 120),
        ])
    }
    
    @objc private func selectPhoto() {
        delegate?.selectPhoto()
    }
}

protocol RegisterViewDelegate: AnyObject, ImageViewPikerDelegate {
    func createNewUser()
}

class RegisterView: UIView {
    
    private weak var delegate: RegisterViewDelegate?
    
    public let scroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .white
        return scroll
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let registerText: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .black
        text.font = UIFont.systemFont(ofSize: 42, weight: .bold)
        text.text = "Registration"
        return text
    }()
    
    private let registerSubText: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .lightGray
        text.font = UIFont.systemFont(ofSize: 16, weight: .light)
        text.text = "Enter your details to register"
        return text
    }()
    
    public let emailTF: UITextField = AuthTextFieldFactory.createTextField(placeholderText: "Enter your email")
    
    public let passwordTF: UITextField = AuthTextFieldFactory.createPasswordTextField(placeholderText: "Password")
    
    public let repeatPasswordTF: UITextField = AuthTextFieldFactory.createPasswordTextField(placeholderText: "Repeat password")
    
    public let nameTF: UITextField = AuthTextFieldFactory.createTextField(placeholderText: "Your name")
    
    public let tagTF: UITextField = AuthTextFieldFactory.createTextField(placeholderText: "Your tag")
    
    public lazy var selectPhotoButton: ImageViewPiker = ImageViewPiker(delegate: delegate!)
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .customRed
        button.addTarget(self, action: #selector(createNewUser), for: .touchUpInside)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        return button
    }()
    
    init(delegate: RegisterViewDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        backgroundColor = .white
        
        let safeArea = safeAreaLayoutGuide
        let sideInsert: CGFloat = 16
        
        addSubview(scroll)
        
        //MARK: scroll
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scroll.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
        scroll.addSubview(contentView)
        
        //MARK: contentView
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scroll.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scroll.widthAnchor)
        ])
        
        [
            registerText,
            registerSubText,
            emailTF,
            passwordTF,
            repeatPasswordTF,
            nameTF,
            tagTF,
            selectPhotoButton,
            signUpButton
        ]
            .forEach({ contentView.addSubview($0)})
        
        //MARK: registerText
        NSLayoutConstraint.activate([
            registerText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            registerText.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        //MARK: registerSubText
        NSLayoutConstraint.activate([
            registerSubText.topAnchor.constraint(equalTo: registerText.bottomAnchor, constant: 10),
            registerSubText.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        //MARK: emailTF
        NSLayoutConstraint.activate([
            emailTF.topAnchor.constraint(equalTo: registerSubText.bottomAnchor, constant: 100),
            emailTF.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideInsert),
            emailTF.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sideInsert),
            emailTF.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        //MARK: passwordTF
        NSLayoutConstraint.activate([
            passwordTF.topAnchor.constraint(equalTo: emailTF.bottomAnchor, constant: sideInsert),
            passwordTF.leadingAnchor.constraint(equalTo: emailTF.leadingAnchor),
            passwordTF.trailingAnchor.constraint(equalTo: emailTF.trailingAnchor),
            passwordTF.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        //MARK: repeatPasswordTF
        NSLayoutConstraint.activate([
            repeatPasswordTF.topAnchor.constraint(equalTo: passwordTF.bottomAnchor, constant: sideInsert),
            repeatPasswordTF.leadingAnchor.constraint(equalTo: emailTF.leadingAnchor),
            repeatPasswordTF.trailingAnchor.constraint(equalTo: emailTF.trailingAnchor),
            repeatPasswordTF.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        //MARK: nameTF
        NSLayoutConstraint.activate([
            nameTF.topAnchor.constraint(equalTo: repeatPasswordTF.bottomAnchor, constant: 2 * sideInsert),
            nameTF.leadingAnchor.constraint(equalTo: emailTF.leadingAnchor),
            nameTF.trailingAnchor.constraint(equalTo: emailTF.trailingAnchor),
            nameTF.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        //MARK: tagTF
        NSLayoutConstraint.activate([
            tagTF.topAnchor.constraint(equalTo: nameTF.bottomAnchor, constant: sideInsert),
            tagTF.leadingAnchor.constraint(equalTo: emailTF.leadingAnchor),
            tagTF.trailingAnchor.constraint(equalTo: emailTF.trailingAnchor),
            tagTF.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        //MARK: selectPhotoButton
        NSLayoutConstraint.activate([
            selectPhotoButton.topAnchor.constraint(equalTo: tagTF.bottomAnchor, constant: 3*sideInsert),
            selectPhotoButton.leadingAnchor.constraint(equalTo: emailTF.leadingAnchor),
            selectPhotoButton.trailingAnchor.constraint(equalTo: emailTF.trailingAnchor),
            selectPhotoButton.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        //MARK: signUpButton
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: selectPhotoButton.bottomAnchor, constant: sideInsert * 2),
            signUpButton.leadingAnchor.constraint(equalTo: emailTF.leadingAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: emailTF.trailingAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 60),
            signUpButton.bottomAnchor.constraint(equalTo: scroll.bottomAnchor, constant: -sideInsert * 2)
        ])
    }
    
    @objc private func createNewUser() {
        delegate?.createNewUser()
    }
    
    @objc private func selectPhoto() {
        delegate?.selectPhoto()
    }
}
