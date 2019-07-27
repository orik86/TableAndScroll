//
//  CellsOptions2.swift
//  TableAndScroll
//
//  Created by orik on 28/07/2019.
//  Copyright © 2019 Aleksandr Gazizov. All rights reserved.
//

import UIKit


class cellsOptions2: UITableViewCell {
    
    
    @IBOutlet weak var imageCol: UIImageView!
    
    @IBOutlet weak var imageAuthor: UILabel!
    
    func configureCell(imageC: imageOptions) {
        
        imageAuthor.text = imageC.author
        self.imageCol.image = UIImage(named: "deafaultImage")
        
        DispatchQueue.global().async {
            guard let imageURL = URL(string: imageC.download_url) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.async {
                self.imageCol.image = UIImage(data: imageData)
            }
        }
    }
    
    
}
