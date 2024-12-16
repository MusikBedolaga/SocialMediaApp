//
//  ProfilePostCollectionViewCell.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 21.11.2024.
//

import UIKit

class ProfilePostCollectionViewCell: UICollectionViewCell {
    static let identifier = "ProfilePostCollectionViewCell"
    
    private let postImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "casinoImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .black
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        contentView.addSubview(postImage)
        
        //MARK: postImage
        NSLayoutConstraint.activate([
            postImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
