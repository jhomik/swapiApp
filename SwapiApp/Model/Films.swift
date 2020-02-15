//
//  Films.swift
//  SwapiApp
//
//  Created by Jakub Homik on 13/02/2020.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import Foundation

struct Films: Codable, CategoryItem {
    var title: String
}

struct FilmsResponse: Codable  {
    var results: [Films]
}

extension Films {
    var name: String {
        return self.title
    }
}
