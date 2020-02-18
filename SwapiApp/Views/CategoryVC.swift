//
//  CategoryVC.swift
//  SwapiApp
//
//  Created by Jakub Homik on 11/02/2020.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import UIKit

class CategoryVC: UIViewController {
    
    var tableView = UITableView()
    var item: PeopleResponse?
    var category: Category.AllCases?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        configureTableView()
    }
    
    func configureTableView() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Category")
        print(item)
        
    }
    
    func downloadData() {
        NetworkManager.shared.downloadResponse(endpoint: "people", responseType: PeopleResponse.self) { (result) in
            switch result {
            case .success(let people):
                self.item = people
                print(people)
            case .failure:
                print(ErrorMessage.invalidUrl)
            }
        }
    }
}

extension CategoryVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Category", for: indexPath)
        cell.textLabel?.text = category[indexPath.row].rawValue
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let listVC = ListVC()
<<<<<<< HEAD
        listVC.selectedCategory = item.first
=======
        listVC.selectedCategory =
>>>>>>> newBranch
        navigationController?.pushViewController(listVC, animated: true)
    }
}

