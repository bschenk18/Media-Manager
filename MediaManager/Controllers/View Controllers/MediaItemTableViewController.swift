//
//  MediaItemTableViewController.swift
//  MediaManager
//
//  Created by Benjamin Prentiss on 1/11/23.
//

import UIKit

class MediaItemTableViewController: UITableViewController {
    
    var items: [MediaItem] = []
    var section = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if section == 0 {
            items = items.filter({
                $0.isFavorite == true
            })
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mediaItemCell", for: indexPath)
        
        let item = items[indexPath.row]
        
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = String(item.rating)
        
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMediaItemDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let destination = segue.destination as! MediaItemDetailViewController
            destination.mediaItem = items[indexPath.row]
        }
    }
}

extension MediaItemTableViewController: DeleteItemDelegate {
    func deleteItem(mediaItem: MediaItem) {
        guard let index = items.firstIndex(of: mediaItem) else { return }
        items.remove(at: index)
        tableView.reloadData()
    }
}
