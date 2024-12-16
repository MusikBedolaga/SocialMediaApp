//
//  IconViewFactory.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 14.11.2024.
//

import UIKit

class IconViewFactory {
    static func createImageView(imageName: String?, tintColor: UIColor = .lightGray) -> UIImageView {
        let imageView = UIImageView(image: UIImage(systemName: imageName ?? ""))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = tintColor
        return imageView
    }
}
class CountViewFactory {
    static func createCountViewFactory(count: String?) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.text = count ?? "0"
        return label
    }
}
