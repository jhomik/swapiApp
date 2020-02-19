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
    var categoryItem: CategoryResponseResults?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTableView()
        downloadCategories()
    }
    
    func configureTableView() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ListVC")
    
    }
    
    
    func downloadCategories() {
        
        guard let selectedCat = selectedCategory else { return }
        
        NetworkManager.shared.downloadResponse(endpoint: selectedCat.rawValue, responseType: CategoryResponseResults.self) { [weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let categories):
                    self.categoryItem = categories
                    self.tableView.reloadData()
                case .failure:
                    print(ErrorMessage.invalidTask)
                }
            }
        }
    }
}

extension ListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categoryItem?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListVC", for: indexPath)
        cell.textLabel?.text = categoryItem?.results[indexPath.row].name
        
        return cell
    }
}

