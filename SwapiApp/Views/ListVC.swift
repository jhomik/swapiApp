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
<<<<<<< HEAD
    var selectedCategory: PeopleResponse?
    //var selectedCategory = [PeopleResponse]()

=======
    var selectedCategory: CategoryResponse?
    
>>>>>>> newBranch
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTableView()
    }
    
    func configureTableView() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ListVC")
    
    }
}

extension ListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
<<<<<<< HEAD
        return selectedCategory?.results.count ?? 0
=======
        return selectedCategory
>>>>>>> newBranch
        /// There was only one selectedCaregory value, the names are inside the results property
        // return selectedCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListVC", for: indexPath)
<<<<<<< HEAD
        cell.textLabel?.text = selectedCategory?.results[indexPath.row].name
        // cell.textLabel!.text = selectedCategory[indexPath.row].results[indexPath.row].name
=======
        cell.textLabel?.text = selectedCategory?.films[i]
>>>>>>> newBranch
        return cell
    }
    
}
