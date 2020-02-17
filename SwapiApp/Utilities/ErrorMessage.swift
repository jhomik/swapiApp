//
//  ErrorMessage.swift
//  SwapiApp
//
//  Created by Jakub Homik on 13/02/2020.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import Foundation

enum ErrorMessage: String, Error {
    case invalidUrl = "Invalid URL"
    case invalidData = "Invalid Data"
    case invalidResponse = "Invalid Response"
    case invalidJson = "Invalid Json"
    case invalidTask = "Invalid Task"
}
