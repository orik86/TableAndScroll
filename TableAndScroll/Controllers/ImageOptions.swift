//
//  imageOptions.swift
//  TableAndScroll
//
//  Created by Aleksandr Gazizov on 26/07/2019.
//  Copyright © 2019 Aleksandr Gazizov. All rights reserved.
//

import Foundation

struct imageOptions: Decodable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
    let download_url: String
}

extension imageOptions {
    var stringWidth: String {
        return String(width)
    }
    var stringHeight: String {
        return String(height)
    }
}
