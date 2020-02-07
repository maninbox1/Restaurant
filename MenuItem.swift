//
//  MenuItem.swift
//  Restaurant
//
//  Created by Mikhail Ladutska on 1/31/20.
//  Copyright © 2020 Mikhail Ladutska. All rights reserved.
//

import Foundation

struct MenuItem: Codable {
    var id: Int
    var name: String
    var detailText: String
    var price: Double
    var category: String
    var imageUrl: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case detailText = "description"
        case price
        case category
        case imageUrl = "image_url"
    }
    
}

struct MenuItems: Codable {
    let items: [MenuItem]
}
