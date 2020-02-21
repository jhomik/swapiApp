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
        //        createTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = ""
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = false
        
    }
    
    func configureTableView() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SwapiCell.self, forCellReuseIdentifier: SwapiCell.reuseId)
        tableView.rowHeight = 80
    }
    
    func downloadCategories() {
        guard let selectedCat = selectedCategory else { return }
        
        NetworkManager.shared.downloadResponse(endpoint: selectedCat.rawValue.lowercased(), responseType: CategoryResponseResults.self) { [weak self] (result) in
            guard let self = self else { return }
            self.createSpinnerView()
            
            switch result {
            case .success(let categories):
                DispatchQueue.main.async {
                    self.categoryItem = categories
                    self.tableView.reloadData()
                    self.removeSpinner()
                }
            case .failure:
                print(ErrorMessage.invalidTask)
            }
        }
    }
}


extension ListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let catItem = categoryItem else { return 0 }
        return catItem.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SwapiCell.reuseId, for: indexPath) as! SwapiCell
        cell.labelCell.text = categoryItem?.results[indexPath.row].text
        cell.imageCell.image = selectedCategory?.labelForCategory
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return selectedCategory?.labelForList
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
}

var spinnerView: UIView?

extension UIViewController {
    
    func createSpinnerView() {
        DispatchQueue.main.async {
            let spinner = UIView(frame: self.view.bounds)
            spinner.backgroundColor = UIColor(white: 0, alpha: 0.7)
            
            let ai = UIActivityIndicatorView(style: .large)
            ai.center = spinner.center
            ai.startAnimating()
            spinner.addSubview(ai)
            self.view.addSubview(spinner)
            spinnerView = spinner
        }
    }
    
    func removeSpinner() {
        
        DispatchQueue.main.async {
            spinnerView?.removeFromSuperview()
            spinnerView = nil
        }
    }
}

