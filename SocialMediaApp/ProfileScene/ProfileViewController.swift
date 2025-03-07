//
//  ProfileViewController.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 08.11.2024.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController {

    private lazy var profileView: ProfileView = ProfileView()
    
    private lazy var profileViewModel: ProfileViewModel = ProfileViewModel(delegate: self)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileView.postCollection.reloadData()
        profileView.setupUser(tag: profileViewModel.currentUser?.tag ?? "@tag",
                              image: profileViewModel.currentUser?.photo ?? Data())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view = profileView
        view.backgroundColor = .white
        self.title = "Профиль"
        
        profileView.backToFeedButton.addTarget(self, action: #selector(backToFeed), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileView.backToFeedButton)
        profileView.checkNewMessageButton.addTarget(self, action: #selector(checkNewMessage), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: profileView.checkNewMessageButton)
        
        profileView.setupProfilePostCollection(delegate: self, dataSource: self)
    }
    
    @objc private func backToFeed() {
        print("backToFeed")
    }
    
    @objc private func checkNewMessage() {
        print("checkNewMessage")
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 30) / 3
        return CGSize(width: width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
}

//MARK: - UICollectionViewDataSource
extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        profileViewModel.frc?.fetchedObjects?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfilePostCollectionViewCell.identifier, for: indexPath) as! ProfilePostCollectionViewCell
        
        guard let post = profileViewModel.frc?.object(at: indexPath), let content = post.content else { return cell}
        cell.configure(image: content)
        
        return cell
    }
}

//MARK: - NSFetchedResultsControllerDelegate
extension ProfileViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.profileView.postCollection.reloadData()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
        self.profileView.postCollection.reloadData()
    }
}
