//
//  PersonalMessageCollectionViewCell.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 26.02.2025.
//

import UIKit

class PersonalMessageCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PersonalMessageCollectionViewCell"
    
    private let bubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customRed
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "text"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(bubbleView)
        bubbleView.addSubview(messageLabel)
        
        //MARK: messageLabel
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: 8),
            messageLabel.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -8),
            messageLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 12),
            messageLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -12),
        ])
        
        //MARK: bubleView
        NSLayoutConstraint.activate([
            bubbleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            bubbleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            bubbleView.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            bubbleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            bubbleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
    }
    
    public func configure(with text: String, isOutgoing: Bool) {
        bubbleView.backgroundColor = isOutgoing ? UIColor.customRed : UIColor.lightGray
        
        messageLabel.text = text
        messageLabel.textColor = isOutgoing ? UIColor.customLightGray : UIColor.black
        messageLabel.preferredMaxLayoutWidth = contentView.frame.width - 32
        

        let leading = bubbleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: isOutgoing ? 50 : 16)
        let trailing = bubbleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: isOutgoing ? -16 : -50)

        leading.priority = .defaultHigh
        trailing.priority = .required
        
        leading.isActive = !isOutgoing
        trailing.isActive = isOutgoing
        
        layoutIfNeeded()
    }
}
