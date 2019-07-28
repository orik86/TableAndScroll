//
//  FavoritsTableVIewController.swift
//  TableAndScroll
//
//  Created by orik on 28/07/2019.
//  Copyright © 2019 Aleksandr Gazizov. All rights reserved.
//

import UIKit

class FavoritsTableViewController: TableViewController {
    
    var favoritsColletion: [imageOptions] = []
    override func viewDidLoad() {
        super.viewDidLoad()
     //   self.tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritsColletion.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! cellsOptions2
        let imagecoll = favoritsColletion[indexPath.row]
        cell.configureCell(imageC: imagecoll)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .default, title: "Delete") { _, _ in
            self.deleteImage(indexPath: indexPath)
        }
        return [delete]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if let indexPath = tableView.indexPathForSelectedRow {
        if segue.identifier == "favoritsScrollSegue" {
            let imageInfo = segue.destination as! ScrollViewController
            imageInfo.imageInfoView = favoritsColletion[indexPath.row]
            }
        }
    }
    
    override func deleteImage(indexPath: IndexPath) {
            self.favoritsColletion.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    
}
