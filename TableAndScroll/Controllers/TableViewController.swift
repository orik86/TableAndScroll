//
//  TableController.swift
//  TableAndScroll
//
//  Created by Aleksandr Gazizov on 26/07/2019.
//  Copyright © 2019 Aleksandr Gazizov. All rights reserved.
//

import UIKit


class TableViewController: UITableViewController {
    
    var urlString = ""

    var imagesCollection: [imageOptions] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagesCollection.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! cellsOptions
        let imagecoll = imagesCollection[indexPath.row]
        cell.configureCell(imageC: imagecoll)
        return cell
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "scrollSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let imageInfo = segue.destination as! ScrollViewController
                imageInfo.imageInfoView = imagesCollection[indexPath.row]
            }
        }
    }
    
    func LoadData() {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            guard error == nil else { return }
            
            do {
                self.imagesCollection = try JSONDecoder().decode([imageOptions].self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch let error {
                print(error)
            }
            }.resume()
        
    }
    
}
