//
//  IntermediaryModels.swift
//  Restaurant
//
//  Created by Mikhail Ladutska on 1/31/20.
//  Copyright © 2020 Mikhail Ladutska. All rights reserved.
//

import Foundation

struct Categories: Codable {
    var categories: [String]
}

struct PreparationTime: Codable {
    var prepTime: Int
    
    enum CodingKeys: String, CodingKey {
        case prepTime = "preparation_time"
    }
}
