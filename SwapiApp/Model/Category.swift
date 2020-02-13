//
//  Category.swift
//  SwapiApp
//
//  Created by Jakub Homik on 11/02/2020.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import Foundation

enum CategoryId {
    case people
    case planets
    case films
    case species
    case vehicles
    case starships
}

struct Category {
    var id: CategoryId
    var name: String
    var response: CategoryResponse
}

struct CategoryResponse: Codable {
    var people: String
    var planets: String
    var films: String
    var species: String
    var vehicles: String
    var starships: String
}
