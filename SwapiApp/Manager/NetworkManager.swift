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
    
    func downloadResponse<T: Codable>(endpoint: String, responseType: T.Type, closure: @escaping(Result<[T], Error>) -> Void) {
        
        guard let url = URL(string: baseUrl + endpoint) else {
            closure(.failure(ErrorMessage.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                closure(.failure(ErrorMessage.invalidTask))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                closure(.failure(ErrorMessage.invalidResponse))
                return
            }
            
            guard let data = data else {
                closure(.failure(ErrorMessage.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(responseType.self, from: data)
                closure(.success([result]))
            } catch {
                closure(.failure(ErrorMessage.invalidJson))
            }
        }
        
        task.resume()
        
    }
    
}
