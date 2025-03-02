//
//  CreateNewChatTableViewController.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 02.03.2025.
//

import UIKit
import CoreData


protocol CreateNewChatDelegate: AnyObject {
    func didCreateNewChat()
}

class CreateNewChatTableViewController: UITableViewController {
    
    weak var delegate: CreateNewChatDelegate?
    
    private let coreDataManager = CoreDataManager.defaultConfig
    
    private lazy var creatNewChatViewModel = CreatNewChatViewModel(delegate: self)
    
    private lazy var frc = creatNewChatViewModel.fetchController

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: NSNotification.Name("NewChatDataUpdated"), object: nil)
    }
    
    @objc private func updateUI() {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return frc?.fetchedObjects?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = frc?.object(at: indexPath).name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            coreDataManager.getCurrentUser { currentUser in
                self.coreDataManager.getUserForEmail(email: cell.textLabel!.text!) { user in
                    if let user1 = currentUser, let user2 = user {
                        self.coreDataManager.addNewConversation(user1: user1, user2: user2)
                        
                        if self.coreDataManager.chatExistsBetween(user1: user1, user2: user2) {
                            print("Чат уже существует!")
                            DispatchQueue.main.async {
                                self.dismiss(animated: true)
                            }
                            return
                        }
                        
                        DispatchQueue.main.async {
                            self.delegate?.didCreateNewChat()
                            self.dismiss(animated: true)
                        }
                    }
                }
            }
        }
    }
}

extension CreateNewChatTableViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }

}
