//
//  PersonalMessageViewController.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 26.02.2025.
//

import UIKit

class PersonalMessageViewController: UIViewController {
    
    private lazy var personalMessageView = PersonalMessageView(delegate: self)
    
    override func viewWillAppear(_ animated: Bool) {
        personalMessageView.personalMessageCollectionView.reloadData()
        personalMessageView.personalMessageCollectionView.layoutIfNeeded()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        navigationItem.hidesBackButton = true
        view = personalMessageView
        
        personalMessageView.setupPersonalMessageCollection(delegate: self, dataSource: self)
    }
}

//MARK: - OutputMessageViewDelegate
extension PersonalMessageViewController: OutputMessageViewDelegate {
    func pushMessage() {
        print("Отпраивть!")
    }
}

//MARK: - UICollectionViewDataSource
extension PersonalMessageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = personalMessageView.personalMessageCollectionView.dequeueReusableCell(withReuseIdentifier: PersonalMessageCollectionViewCell.identifier, for: indexPath) as! PersonalMessageCollectionViewCell
        cell.backgroundColor = .white
        return cell
    }
}

//MARK: - UICollectionViewDataSource
extension PersonalMessageViewController: UICollectionViewDelegateFlowLayout {
    var sideInsert: CGFloat { return 5 }
    var sideBetween: CGFloat { return 3 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sideBetween
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        UIEdgeInsets(top: sideBetween, left:  0, bottom: 0, right: sideBetween )
//        
//    }

}

