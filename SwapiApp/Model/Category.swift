//
//  Category.swift
//  SwapiApp
//
//  Created by Jakub Homik on 11/02/2020.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import UIKit

enum Category: String, CaseIterable {
    case people = "People"
    case planets = "Planets"
    case films = "Films"
    case species = "Species"
    case vehicles = "Vehicles"
    case starships = "Starships"
}

struct CategoryResponse: Codable {
    var name: String?
    var title: String?
    var text: String {
        return self.name ?? self.title ?? ""
    }
    
    private enum CodingKeys: String, CodingKey {
        case name, title
    }
}
struct CategoryResponseResults: Codable {
    var results: [CategoryResponse]
}

