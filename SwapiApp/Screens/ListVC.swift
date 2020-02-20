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
        createTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
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
        
        NetworkManager.shared.downloadResponse(endpoint: selectedCat.rawValue.lowercased(), responseType: CategoryResponseResults.self) { [weak self] (result) in
            guard let self = self else { return }
            
                switch result {
                case .success(let categories):
                    DispatchQueue.main.async {
                        self.categoryItem = categories
                        self.tableView.reloadData()
                    }
                case .failure:
                    print(ErrorMessage.invalidTask)
                }
            }
        }
    
    func createTitle() {
        guard let selectedCat = selectedCategory else { return }
        title = selectedCat.rawValue
    }
}

extension ListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let catItem = categoryItem else { return 0 }
        return catItem.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListVC", for: indexPath)
        cell.textLabel?.text = categoryItem?.results[indexPath.row].text
        
        return cell
    }
}

