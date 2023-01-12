//
//  HomeTableViewController.swift
//  MediaManager
//
//  Created by Benjamin Prentiss on 1/9/23.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reminderFired), name: Notification.Name(rawValue: "mediaReminderNotification"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Methods
    @objc func reminderFired() {
        DispatchQueue.main.async {
            self.tableView.backgroundColor = .red
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.tableView.backgroundColor = .systemBackground
            self.view.backgroundColor = .systemBackground
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath)
        
        if indexPath.row == 0 {
            cell.textLabel?.text = "Favorites"
        } else if indexPath.row == 1 {
            cell.textLabel?.text = "Movies"
        } else {
            cell.textLabel?.text = "TV Shows"
        }
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMediaItemVC" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let destination = segue.destination as! MediaItemTableViewController
            destination.items = MediaItemController.shared.sections[indexPath.row]
            destination.section = indexPath.row
        }
    }
}
