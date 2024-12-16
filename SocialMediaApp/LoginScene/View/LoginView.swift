//
//  LoginView.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 03.11.2024.
//

import UIKit

protocol LoginViewDelegate: AnyObject {
    func signIn()
    func signUp()
}

class LoginView: UIView {
    
    private weak var delegate: LoginViewDelegate?
    
    public let scrollView: UIScrollView = {
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
    
    private let greetingsText: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .black
        text.font = UIFont.systemFont(ofSize: 42, weight: .bold)
        text.text = "Hello again!"
        return text
    }()
    
    private let signInText: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .lightGray
        text.font = UIFont.systemFont(ofSize: 16, weight: .light)
        text.text = "Sign in to your account"
        return text
    }()
    
    public let emailTF: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .black
        textField.placeholder = "Email adress"
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.font = UIFont.systemFont(ofSize: 16)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }()
    
    public let passwordTF: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .black
        textField.placeholder = "Password"
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.font = UIFont.systemFont(ofSize: 16)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 2
        button.backgroundColor = .customRed
        button.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        return button
    }()
    
    private let signUpView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let signUpText: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = "Don't have account. Let's"
        text.font = UIFont.systemFont(ofSize: 14, weight: .light)
        text.textColor = .lightGray
        return text
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign up", for: .normal)
        button.setTitleColor(.customRed, for: .normal)
        button.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        return button
    }()

    init(delegate: LoginViewDelegate) {
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
        let sideIndent: CGFloat = 16
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        //MARK: scrollView
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
        //MARK: contentView
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        [
            greetingsText,
            signInText,
            emailTF,
            passwordTF,
            signInButton,
            signUpView
        ].forEach({ scrollView.addSubview($0) })
        
        //MARK: greetingsText
        NSLayoutConstraint.activate([
            greetingsText.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            greetingsText.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 50),
            greetingsText.bottomAnchor.constraint(equalTo: signInText.topAnchor, constant: -10)
        ])
        
        //MARK: signInText
        NSLayoutConstraint.activate([
            signInText.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            signInText.topAnchor.constraint(equalTo: greetingsText.bottomAnchor, constant: 10),
            signInText.bottomAnchor.constraint(equalTo: emailTF.topAnchor, constant: -100)
        ])
        
        //MARK: emailTF
        NSLayoutConstraint.activate([
            emailTF.topAnchor.constraint(equalTo: signInText.bottomAnchor, constant: 100),
            emailTF.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            emailTF.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: sideIndent),
            emailTF.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -sideIndent),
            emailTF.bottomAnchor.constraint(equalTo: passwordTF.topAnchor, constant: -16),
            emailTF.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        //MARK: passwordTF
        NSLayoutConstraint.activate([
            passwordTF.topAnchor.constraint(equalTo: emailTF.bottomAnchor, constant: 16),
            passwordTF.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            passwordTF.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: sideIndent),
            passwordTF.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -sideIndent),
            passwordTF.heightAnchor.constraint(equalTo: emailTF.heightAnchor)
        ])
        
        //MARK: signInButton
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalTo: passwordTF.bottomAnchor, constant: 50),
            signInButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: sideIndent),
            signInButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -sideIndent),
            signInButton.heightAnchor.constraint(equalToConstant: 60)
            
        ])
        
        //MARK: createView
        NSLayoutConstraint.activate([
            signUpView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -sideIndent),
            signUpView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: sideIndent * 5),
            signUpView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -sideIndent * 5),
            signUpView.heightAnchor.constraint(equalToConstant: 50),
            signUpView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: sideIndent)
        ])
        
        [signUpText, signUpButton].forEach({ signUpView.addSubview($0) })
        
        //MARK: createNewAccText
        NSLayoutConstraint.activate([
            signUpText.centerYAnchor.constraint(equalTo: signUpView.centerYAnchor),
            signUpText.leadingAnchor.constraint(equalTo: signUpView.leadingAnchor)
        ])
        
        //MARK: signUpButton
        NSLayoutConstraint.activate([
            signUpButton.centerYAnchor.constraint(equalTo: signUpView.centerYAnchor),
            signUpButton.leadingAnchor.constraint(equalTo: signUpText.trailingAnchor, constant: -6),
            signUpButton.trailingAnchor.constraint(equalTo: signUpView.trailingAnchor)
        ])
    }
    
    @objc private func signIn() {
        delegate?.signIn()
    }
    
    @objc private func signUp() {
        delegate?.signUp()
    }
}
