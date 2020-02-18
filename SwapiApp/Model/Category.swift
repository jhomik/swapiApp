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

protocol CategoryItem: Codable {
    var name: String { get }
}

struct CategoryResponse: Codable {
    var people: String
    var planets: String
    var films: String
    var species: String
    var vehicles: String
    var starships: String
}
