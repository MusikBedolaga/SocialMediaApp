//
//  AuthTextFieldFactory.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 01.12.2024.
//

import UIKit
import Foundation

class AuthTextFieldFactory {
    static func createTextField(placeholderText: String) -> UITextField {
        let textField = UITextField()
        configureTextField(textField: textField, text: placeholderText)
        return textField
    }
    
    static func createPasswordTextField(placeholderText: String) -> UITextField {
        let textField = UITextField()
        configureTextField(textField: textField, text: placeholderText)
        textField.isSecureTextEntry = true
        return textField
    }
    
    private static func configureTextField(textField: UITextField, text: String) {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .black
        textField.placeholder = text
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.font = UIFont.systemFont(ofSize: 16)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        textField.leftView = paddingView
        textField.leftViewMode = .always
    }
}
