//
//  ListVC.swift
//  SwapiApp
//
//  Created by Jakub Homik on 13/02/2020.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import UIKit

class ListVC: UIViewController {
    
    var tableView = UITableView()
    var selectedCategory: Category?
    var peopleItem: PeopleResponse?
    var planetsItem: PlanetsResponse?
    var filmsItem: FilmsResponse?
    var speciesItem: SpeciesResponse?
    var vehiclesItem: VehiclesResponse?
    var starshipsItem: StarshipsResponse?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTableView()
        selectCategory()
    }
    
    func configureTableView() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ListVC")
        
    }
    
    func downloadPeople() {
        
        NetworkManager.shared.downloadResponse(endpoint: Category.people.rawValue.lowercased(), responseType: PeopleResponse.self) { [weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let people):
                    self.peopleItem = people
                    self.tableView.reloadData()
                case .failure:
                    print(ErrorMessage.invalidTask)
                }
            }
        }
    }
    
    func downloadPlanets() {
        
        NetworkManager.shared.downloadResponse(endpoint: Category.planets.rawValue.lowercased(), responseType: PlanetsResponse.self) { [weak self] (result) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let planets):
                    self.planetsItem = planets
                    self.tableView.reloadData()
                case .failure:
                    print(ErrorMessage.invalidTask)
                }
            }
        }
    }
    
    func downloadFilms() {
        
        NetworkManager.shared.downloadResponse(endpoint: Category.films.rawValue.lowercased(), responseType: FilmsResponse.self) { [weak self] (result) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let films):
                    self.filmsItem = films
                    self.tableView.reloadData()
                case .failure:
                    print(ErrorMessage.invalidData)
                }
            }
        }
    }
    
    func downloadSpecies() {
        
        NetworkManager.shared.downloadResponse(endpoint: Category.species.rawValue.lowercased(), responseType: SpeciesResponse.self) { [weak self] (result) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let species):
                    self.speciesItem = species
                    self.tableView.reloadData()
                case .failure:
                    print(ErrorMessage.invalidData)
                }
            }
        }
    }
    
    func downloadVehicles() {
        
        NetworkManager.shared.downloadResponse(endpoint: Category.vehicles.rawValue.lowercased(), responseType: VehiclesResponse.self) { [weak self] (result) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let vehicles):
                    self.vehiclesItem = vehicles
                    self.tableView.reloadData()
                case .failure:
                    print(ErrorMessage.invalidData)
                }
            }
        }
    }
    
    func downloadStarships() {
        
        NetworkManager.shared.downloadResponse(endpoint: Category.starships.rawValue.lowercased(), responseType: StarshipsResponse.self) { [weak self](result) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let starships):
                    self.starshipsItem = starships
                    self.tableView.reloadData()
                case .failure:
                    print(ErrorMessage.invalidData)
                }
            }
        }
    }
    
    func selectCategory() {
        
        let item = self.selectedCategory
        
        switch item {
        case .people:
            self.downloadPeople()
        case .planets:
            self.downloadPlanets()
        case .films:
            self.downloadFilms()
        case .species:
            self.downloadSpecies()
        case .vehicles:
            self.downloadVehicles()
        case .starships:
            self.downloadStarships()
            
        default: print(ErrorMessage.invalidData)
            
        }
    }
}

extension ListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let people = starshipsItem?.results.count else { return 0 }
        
        //        let numberOfRow = self.selectedCategory
        //        switch numberOfRow {
        //        case .people:
        //            guard let people = peopleItem?.results.count else { return 0 }
        //        case .planets:
        //            guard let planets = planetsItem?.results.count else { return 0 }
        //
        //        default: print(ErrorMessage.invalidData)
        //        }
        //
        //        return numberOfRow.count
        
        return people
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListVC", for: indexPath)
        
        switch self.selectedCategory {
        case .people:
            cell.textLabel?.text = self.peopleItem?.results[indexPath.row].name
        case .planets:
            cell.textLabel?.text = self.planetsItem?.results[indexPath.row].name
        case .films:
            cell.textLabel?.text = self.filmsItem?.results[indexPath.row].name
        case .species:
            cell.textLabel?.text = self.speciesItem?.results[indexPath.row].name
        case .vehicles:
            cell.textLabel?.text = self.vehiclesItem?.results[indexPath.row].name
        case .starships:
            cell.textLabel?.text = self.starshipsItem?.results[indexPath.row].name
            
        default: print(ErrorMessage.invalidData)
        }
        
        return cell
    }
    
}

