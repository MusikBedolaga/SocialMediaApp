//
//  PersonalMessageView.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 26.02.2025.
//

import UIKit

protocol PersonalMessageDelegate: AnyObject {
    func goBack()
    func pushMessage()
}

class PersonalMessageView: UIView {
    
    private let informationMessageView: InformationMessageView = InformationMessageView()
    
    public let personalMessageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PersonalMessageCollectionViewCell.self, forCellWithReuseIdentifier: PersonalMessageCollectionViewCell.identifier)
        collectionView.backgroundColor = .lightBlue
        return collectionView
    }()
    
    private weak var delegate: PersonalMessageDelegate?
    
    public let outputMessageView: OutputMessageView
    
    init(delegate: PersonalMessageDelegate) {
        self.outputMessageView = OutputMessageView()
        super.init(frame: .zero)
        self.outputMessageView.delegate = delegate
        self.informationMessageView.delegate = delegate
        self.delegate = delegate
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        backgroundColor = .lightBlue
        
        [informationMessageView, personalMessageCollectionView, outputMessageView].forEach({ addSubview($0) })
        
        //MARK: informationMessageView
        NSLayoutConstraint.activate([
            informationMessageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -40),
            informationMessageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            informationMessageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            informationMessageView.bottomAnchor.constraint(equalTo: personalMessageCollectionView.topAnchor, constant: -15),
            informationMessageView.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        //MARK: personalMessageCollectionView
        NSLayoutConstraint.activate([
            personalMessageCollectionView.topAnchor.constraint(equalTo: informationMessageView.bottomAnchor),
            personalMessageCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            personalMessageCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            personalMessageCollectionView.bottomAnchor.constraint(equalTo: outputMessageView.topAnchor, constant: -10)
        ])
        
        //MARK: outputMessageView
        NSLayoutConstraint.activate([
            outputMessageView.topAnchor.constraint(equalTo: personalMessageCollectionView.bottomAnchor, constant: 5),
            outputMessageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            outputMessageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            outputMessageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5),
            outputMessageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    public func setupPersonalMessageCollection(delegate: UICollectionViewDelegate,
                                               dataSource: UICollectionViewDataSource) {
        personalMessageCollectionView.delegate = delegate
        personalMessageCollectionView.dataSource = dataSource
    }
    
    public func setupIndorationView(userImage: UIImage?, userName: String?) {
        guard let name = userName else { return }
        
        let image = userImage == nil ? UIImage(named: "legaImage") : userImage
        
        self.informationMessageView.personName.text = name
        self.informationMessageView.personImageView.image = image
    }
}

protocol InformationMessageViewDelegate: AnyObject {
    func goBack()
}

class InformationMessageView: UIView {
    
    weak var delegate: PersonalMessageDelegate?
    
    public let personImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 22
        imageView.clipsToBounds = true
        return imageView
    }()
    
    public let personName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrowshape.backward.fill"), for: .normal)
        button.backgroundColor = .customRed
        button.layer.cornerRadius = 22
        button.tintColor = .white
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        backgroundColor = .lightBlue
        
        setupShadow()
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        [personImageView, personName, backButton].forEach({ addSubview($0) })
        
        //MARK: personImageView
        NSLayoutConstraint.activate([
            personImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            personImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            personImageView.widthAnchor.constraint(equalToConstant: 44),
            personImageView.heightAnchor.constraint(equalTo: personImageView.widthAnchor)
        ])
        
        //MARK: personName
        NSLayoutConstraint.activate([
            personName.centerYAnchor.constraint(equalTo: centerYAnchor),
            personName.leadingAnchor.constraint(equalTo: personImageView.trailingAnchor, constant: 10)
        ])
        
        //MARK: backButton
        NSLayoutConstraint.activate([
            backButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            backButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.masksToBounds = false
    }
    
    @objc private func goBack() {
        delegate?.goBack()
    }
}

protocol OutputMessageViewDelegate: AnyObject {
    func pushMessage()
}

class OutputMessageView: UIView {
    
    weak var delegate: PersonalMessageDelegate?
    
    public let contentTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.placeholder = "Введите текст"
        return textField
    }()
    
    private let pushMessageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .customRed
        button.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(pushMessage), for: .touchUpInside)
        button.tintColor = .white
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        self.layer.cornerRadius = 15
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .white
        
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        
        [contentTextField, pushMessageButton].forEach({ addSubview($0) })
        
        //MARK: contentTextField
        NSLayoutConstraint.activate([
            contentTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            contentTextField.topAnchor.constraint(equalTo: topAnchor),
            contentTextField.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        //MARK: pushMessageButton
        NSLayoutConstraint.activate([
            pushMessageButton.leadingAnchor.constraint(equalTo: contentTextField.trailingAnchor, constant: 5),
            pushMessageButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            pushMessageButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            pushMessageButton.heightAnchor.constraint(equalToConstant: 40),
            pushMessageButton.widthAnchor.constraint(equalTo: pushMessageButton.heightAnchor)
        ])
    }
    
    @objc private func pushMessage() {
        delegate?.pushMessage()
    }
}
