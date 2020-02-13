//
//  Category.swift
//  SwapiApp
//
//  Created by Jakub Homik on 11/02/2020.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import UIKit

 var category = ["People", "Planets", "Films", "Species", "Vehicles", "Starships"]

struct CategoryResponse: Codable {
    var people: String
    var planets: String
    var films: String
    var species: String
    var vehicles: String
    var starships: String
}
