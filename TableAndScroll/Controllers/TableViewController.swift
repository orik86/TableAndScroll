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
    var favoritesImages: [imageOptions] = []
    
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
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .default, title: "Delete") { _, _ in
            self.deleteImage(indexPath: indexPath)
        }
        let symbol = imagesCollection[indexPath.row].favoritesIm
        let favorite = UITableViewRowAction(style: .default, title: symbol) { _, _ in
            self.favoritesImage(indexPath: indexPath)
            
        }
        return [favorite, delete]
    }

 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "scrollSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let imageInfo = segue.destination as! ScrollViewController
                imageInfo.imageInfoView = imagesCollection[indexPath.row]
            }
        } else {
            if segue.identifier == "favoritsSegue" {
                    let imageInfo = segue.destination as! FavoritsTableViewController
                favoritesImages = imagesCollection.filter {$0.favorites == true}
                    imageInfo.favoritsColletion = favoritesImages
                }
            }
        }
    
    @IBAction func favoritesGo(_ sender: Any) {
    }
    
    
    func favoritesImage(indexPath: IndexPath) {
    
        if let fav = imagesCollection[indexPath.row].favorites { imagesCollection[indexPath.row].favorites = !fav } else {
         imagesCollection[indexPath.row].favorites = true
        }
    }
    
    
    func deleteImage(indexPath: IndexPath) {
        self.imagesCollection.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    func LoadData() {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            guard error == nil else { return }
            
            do {
                self.imagesCollection = try JSONDecoder().decode([imageOptions].self, from: data)
                //print(self.imagesCollection)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch let error {
                print(error)
            }
            }.resume()
        
    }
    
}


extension TableViewController {
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        guard segue.identifier == "saveSegue" else { return }
        
        let source = segue.source as! AddTableViewController
        let newImage = source.addImage
        if let selectedPath = tableView.indexPathForSelectedRow {
            imagesCollection[selectedPath.row] = newImage
            tableView.reloadRows(at: [selectedPath], with: .automatic)
        } else {
            let indexPath = IndexPath(row: imagesCollection.count, section: 0)
            imagesCollection.append(newImage)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
        
}
}
