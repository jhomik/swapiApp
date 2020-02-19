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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTableView()
        downloadPeople()
        
        switch self.selectedCategory {
        case .people:
            downloadPeople()
        default: print(ErrorMessage.invalidData)        }
        
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
            switch result {
            case .success(let people):
                self.peopleItem = people
            case .failure:
                print(ErrorMessage.invalidTask)
                
            }
        }
    }
}

extension ListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let people = peopleItem?.results.count else { return 0 }
        return people
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListVC", for: indexPath)
        cell.textLabel?.text = peopleItem?.results[indexPath.row].name
        return cell
    }
    
}

