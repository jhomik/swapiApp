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
    
    func downloadPeople() {
        let endPoint = baseUrl + "people/"
        
        
        guard let url = URL(string: endPoint) else {
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
                let people = try decoder.decode(PeopleResponse.self, from: data)
                print(people)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func downloadPlanets() {
        let endPoint = baseUrl + "planets/"
        
        guard let url = URL(string: endPoint) else {
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
                let planets = try decoder.decode(PlanetsResponse.self, from: data)
                
                print(planets.self)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func downloadFilms() {
        let endPoint = baseUrl + "films/"
        
        guard let url = URL(string: endPoint) else {
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
                let films = try decoder.decode(FilmsResponse.self, from: data)
                
                print(films.self)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func downloadSpecies() {
        let endPoint = baseUrl + "species/"
        
        guard let url = URL(string: endPoint) else {
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
                let species = try decoder.decode(SpeciesResponse.self, from: data)
                
                print(species.self)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func downloadVehicles() {
        let endPoint = baseUrl + "vehicles/"
        
        guard let url = URL(string: endPoint) else {
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
                let vehicles = try decoder.decode(VehiclesResponse.self, from: data)
                
                print(vehicles.self)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func downloadStarships() {
        let endPoint = baseUrl + "starships/"
        
        guard let url = URL(string: endPoint) else {
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
                let starships = try decoder.decode(StarshipsResponse.self, from: data)
                
                print(starships.self)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
}
