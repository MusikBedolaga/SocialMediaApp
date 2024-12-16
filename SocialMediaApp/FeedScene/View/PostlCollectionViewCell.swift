//
//  PostlCollectionViewCell.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 14.11.2024.
//

import UIKit

class HeaderPostView: UIView {
    
    private let profileView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 28
        view.layer.borderWidth = 4
        view.layer.borderColor = UIColor.customRed.cgColor
        view.backgroundColor = .white
        return view
    }()
    
    private let profileImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "profileImage"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 20
        image.layer.masksToBounds = true
        image.backgroundColor = .lightGray
        return image
    }()
    
    private let name: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "kafajfaofa"
        name.textColor = .black
        name.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        name.numberOfLines = 0
        return name
    }()
    
    private let nickName: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "@afmkafa"
        name.textColor = .customRed
        name.font = UIFont.systemFont(ofSize: 13, weight: .light)
        name.numberOfLines = 0
        return name
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        self.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .lightBlue
        
        [profileView, name, nickName].forEach( {addSubview($0)} )
        
        //MARK: profileView
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: self.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            profileView.widthAnchor.constraint(equalToConstant: 56),
            profileView.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        //MARK: name
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            name.leadingAnchor.constraint(equalTo: profileView.trailingAnchor, constant: 2)
        ])
        
        //MARK: nickName
        NSLayoutConstraint.activate([
            nickName.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10),
            nickName.leadingAnchor.constraint(equalTo: name.leadingAnchor)
        ])
        
        profileView.addSubview(profileImage)
        //MARK: profileImage
        NSLayoutConstraint.activate([
            profileImage.centerXAnchor.constraint(equalTo: profileView.centerXAnchor),
            profileImage.centerYAnchor.constraint(equalTo: profileView.centerYAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 40),
            profileImage.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}


class BodyPostView: UIView {
    private let imageContent: UIImageView = {
        let image = UIImageView(image: UIImage(named: "contentImage"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.backgroundColor = .lightGray
        image.layer.cornerRadius = 30
        return image
    }()
    
    private let infoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.translatesAutoresizingMaskIntoConstraints = false
        return effectView
    }()
    
    private let commentIcon: UIImageView = IconViewFactory.createImageView(imageName: "bubble.left.fill")

    private let likeIcon: UIImageView = IconViewFactory.createImageView(imageName: "heart.fill")
    
    private let planeIcon: UIImageView = IconViewFactory.createImageView(imageName: "paperplane.fill")
    
    private let bookmarkIcon: UIImageView = IconViewFactory.createImageView(imageName: "bookmark.fill")
    
    private let countComments: UILabel = CountViewFactory.createCountViewFactory(count: "50")
    
    private let countLikes: UILabel = CountViewFactory.createCountViewFactory(count: "100")
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        self.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .lightBlue
        
        [imageContent].forEach({ addSubview($0) })
        
        //MARK: imageContent
        NSLayoutConstraint.activate([
            imageContent.topAnchor.constraint(equalTo: self.topAnchor),
            imageContent.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageContent.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageContent.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        [infoView].forEach({ imageContent.addSubview($0) })
        
        //MARK: infoView
        NSLayoutConstraint.activate([
            infoView.leadingAnchor.constraint(equalTo: imageContent.leadingAnchor),
            infoView.trailingAnchor.constraint(equalTo: imageContent.trailingAnchor),
            infoView.bottomAnchor.constraint(equalTo: imageContent.bottomAnchor),
            infoView.heightAnchor.constraint(equalToConstant: imageContent.frame.size.width / 7)
        ])
        
        [blurEffectView, commentIcon, countComments, likeIcon, countLikes, planeIcon, bookmarkIcon].forEach({ infoView.addSubview($0) })
        
        //MARK: blurEffectView
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: infoView.topAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: infoView.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: infoView.trailingAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: infoView.bottomAnchor)
        ])
        
        //MARK: commentIcon
        NSLayoutConstraint.activate([
            commentIcon.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 10),
            commentIcon.centerYAnchor.constraint(equalTo: infoView.centerYAnchor),
            commentIcon.widthAnchor.constraint(equalToConstant: 25),
            commentIcon.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        //MARK: countComments
        NSLayoutConstraint.activate([
            countComments.leadingAnchor.constraint(equalTo: commentIcon.trailingAnchor, constant: 5),
            countComments.trailingAnchor.constraint(equalTo: likeIcon.leadingAnchor, constant: -3),
            countComments.centerYAnchor.constraint(equalTo: infoView.centerYAnchor)
        ])
        
        //MARK: likeIcon
        NSLayoutConstraint.activate([
            likeIcon.leadingAnchor.constraint(equalTo: commentIcon.trailingAnchor, constant: 40),
            likeIcon.centerYAnchor.constraint(equalTo: infoView.centerYAnchor),
            likeIcon.widthAnchor.constraint(equalToConstant: 25),
            likeIcon.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        //MARK: countLikes
        NSLayoutConstraint.activate([
            countLikes.leadingAnchor.constraint(equalTo: likeIcon.trailingAnchor, constant: 5),
            countLikes.centerYAnchor.constraint(equalTo: infoView.centerYAnchor),
        ])
        
        //MARK: bookmarkIcon
        NSLayoutConstraint.activate([
            bookmarkIcon.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -10),
            bookmarkIcon.centerYAnchor.constraint(equalTo: infoView.centerYAnchor),
            bookmarkIcon.widthAnchor.constraint(equalToConstant: 25),
            bookmarkIcon.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        //MARK: planeIcon
        NSLayoutConstraint.activate([
            planeIcon.trailingAnchor.constraint(equalTo: bookmarkIcon.leadingAnchor, constant: -15),
            planeIcon.centerYAnchor.constraint(equalTo: infoView.centerYAnchor),
            planeIcon.widthAnchor.constraint(equalToConstant: 25),
            planeIcon.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
}


class PostlCollectionViewCell: UICollectionViewCell {
    static let identifier = "PostlCollectionViewCell"
    
    private let headerPostView = HeaderPostView(frame: .zero)
    
    private let bodyPostView = BodyPostView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        
        contentView.backgroundColor = .lightBlue
        contentView.layer.cornerRadius = 30
        
        
        contentView.addSubview(headerPostView)
        
        //MARK: headerPostView
        NSLayoutConstraint.activate([
            headerPostView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            headerPostView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            headerPostView.widthAnchor.constraint(equalToConstant: contentView.frame.size.width / 2.5),
            headerPostView.heightAnchor.constraint(equalToConstant: 70),
        ])
        
        contentView.addSubview(bodyPostView)
        
        //MARK: bodyPostView
        NSLayoutConstraint.activate([
            bodyPostView.topAnchor.constraint(equalTo: headerPostView.bottomAnchor),
            bodyPostView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            bodyPostView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            bodyPostView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
