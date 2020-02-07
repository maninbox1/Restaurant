//
//  Order.swift
//  Restaurant
//
//  Created by Mikhail Ladutska on 1/31/20.
//  Copyright © 2020 Mikhail Ladutska. All rights reserved.
//

import Foundation

struct Order: Codable {
    var menuItems: [MenuItem]
    
    init(menuItems: [MenuItem] = []) {
        self.menuItems = menuItems
    }
    
}
