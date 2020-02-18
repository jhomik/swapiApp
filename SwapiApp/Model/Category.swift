//
//  Category.swift
//  SwapiApp
//
//  Created by Jakub Homik on 11/02/2020.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import UIKit

protocol CategoryItem {
    var name: String { get }
}

enum Category: String, CaseIterable {
    case people = "People"
    case planets = "Planets"
    case films = "Films"
    case species = "Species"
    case vehicles = "Vehicles"
    case starships = "Starships"
}
