//
//  NetworkManager.swift
//  SwapiApp
//
//  Created by Jakub Homik on 11/02/2020.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let baseUrl = "https://swapi.co/api/"
    
    func downloadResponse() {
        
        let endpoint = baseUrl + "people"
        
        guard let url = URL(string: endpoint) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let category = try decoder.decode(CategoryResponse.self, from: data)
                
                print(category.self)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
