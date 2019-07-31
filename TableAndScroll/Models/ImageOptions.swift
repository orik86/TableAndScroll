//
//  imageOptions.swift
//  TableAndScroll
//
//  Created by Aleksandr Gazizov on 26/07/2019.
//  Copyright © 2019 Aleksandr Gazizov. All rights reserved.
//

import Foundation

struct imageOptions: Decodable {
    var id: String
    var author: String
    var width: Int
    var height: Int
    var url: String
    var download_url: String
    var favorites: Bool?
    
    init(id: String = "", author: String = "", width: Int = 0, height: Int = 0, url: String = "", download_url: String = "", favorites: Bool = false)  {
        self.id = id
        self.author = author
        self.width = width
        self.height = height
        self.url = url
        self.download_url = download_url
        self.favorites = favorites
        
    }
    
    
}



extension imageOptions {
    var stringWidth: String {
        return String(width)
    }
    var stringHeight: String {
        return String(height)
    }
    var favoritesIm: String {
        if favorites == true {
            return "⭐️"
        } else {
            return "✩"
        }
    }
}
