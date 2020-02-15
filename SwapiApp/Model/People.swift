//
//  People.swift
//  SwapiApp
//
//  Created by Jakub Homik on 13/02/2020.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import Foundation

struct People: Codable, CategoryItem {
    var name: String
}

struct PeopleResponse: Codable {
    
    var results: [People]
}
