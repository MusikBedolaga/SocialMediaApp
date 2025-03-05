//
//  PhotoChangeTableViewCell.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 05.03.2025.
//

import Foundation
import UIKit

class PhotoChangeTableViewCell: UITableViewCell {
    
    static let identifier = "PhotoChangeTableViewCell"
    
    weak var delegate: TableViewCellDelegate?
    
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "default_avatar")
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    private let changePhotoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Сменить фото", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(changePhotoAction), for: .touchUpInside)
        button.backgroundColor = .customRed
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(photoImageView)
        contentView.addSubview(changePhotoButton)
        
        //MARK: photoImageView
        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            photoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            photoImageView.widthAnchor.constraint(equalToConstant: 50),
            photoImageView.heightAnchor.constraint(equalToConstant: 50),
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: photoImageView.bottomAnchor, constant: 10),
        ])
        
        //MARK: changePhotoButton
        NSLayoutConstraint.activate([
            changePhotoButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            changePhotoButton.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 100),
            changePhotoButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(photoTapped))
        photoImageView.isUserInteractionEnabled = true
        photoImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func photoTapped() {
        delegate?.didTapChangePhoto(self)
    }
    
    @objc private func changePhotoAction() {
        delegate?.changePhotoAction()
    }
    
    public func setupCell(image: UIImage) {
        photoImageView.image = image
    }
}
