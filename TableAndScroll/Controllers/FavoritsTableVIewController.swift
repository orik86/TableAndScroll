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
        print(favoritsColletion)
        self.tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritsColletion.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! cellsOptions
        let imagecoll = favoritsColletion[indexPath.row]
        cell.configureCell(imageC: imagecoll)
        return cell
    }
}
