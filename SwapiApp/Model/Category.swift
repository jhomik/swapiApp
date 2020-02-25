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
    
    var labelForCategory: UIImage? {
        
        switch self {
        case .people:
            return UIImage(named: "Leia-icon_34495")
        case .planets:
            return UIImage(named: "icons8-rebel-50")
        case .films:
           return UIImage(named: "Stormtrooper-icon_34494")
        case .species:
           return UIImage(named: "iconfinder_chewbacca_2981859")
        case .vehicles:
            return UIImage(named: "iconfinder_Millennium-Falcon_2981858")
        case .starships:
            return UIImage(named: "Death-Star-icon_34500")
        }
    }
    
    var labelForList: UIImageView? {
        
        switch self {
        case .people:
            return UIImageView(image: UIImage(named: "people"))
        case .planets:
            return UIImageView(image: UIImage(named: "planets"))
        case .films:
            return UIImageView(image: UIImage(named: "films"))
        case .species:
            return UIImageView(image: UIImage(named: "species"))
        case .vehicles:
            return UIImageView(image: UIImage(named: "vehicles"))
        case .starships:
            return UIImageView(image: UIImage(named: "starships"))
        }
    }
    
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

class CategoryResponseResults: Codable {
    var results: [CategoryResponse]
}

