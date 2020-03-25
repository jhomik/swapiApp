//
//  FavoritesVC.swift
//  SwapiApp
//
//  Created by Jakub Homik on 24/03/2020.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController {
    
    var tableView: UITableView!
    
    private var list: [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
    }
    
    func configureTableView() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Favorites")
        
    }
}


extension FavoritesVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Favorites", for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
}

extension FavoritesVC: FavoriteDelegateData {
    func addDataToFavorite(_ textfield: String) {
        list.append(textfield)
    }

    
}

