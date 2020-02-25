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
    var page = 1
    var hasMoreList = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTableView()
        downloadCategories(page: page)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = ""
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = false
        
    }
    
    func createSpinnerView() {
        if self.categoryItem == nil || self.categoryItem?.results.count == 0 {
            
            let ai = UIActivityIndicatorView(style: .large)
            ai.center = view.center
            ai.accessibilityIdentifier = "Spinner"
            ai.startAnimating()
            DispatchQueue.main.async {
                self.tableView.isHidden = true
                self.view.addSubview(ai)
            }
        } else if self.categoryItem != nil || self.categoryItem?.results.count != 0 {
            
            let ai = UIActivityIndicatorView(style: .medium)
            ai.center = view.center
            ai.accessibilityIdentifier = "Spinner"
            ai.startAnimating()
            DispatchQueue.main.async {
                self.tableView.isHidden = false
                self.view.addSubview(ai)
            }
        }
    }
    
    func removeSpinner() {
        guard let ai = self.view.subviews.first(where: {$0 is UIActivityIndicatorView && $0.accessibilityIdentifier == "Spinner" }) else { return }
        DispatchQueue.main.async {
            self.tableView.isHidden = false
            ai.removeFromSuperview()
        }
    }
    
    func configureTableView() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SwapiCell.self, forCellReuseIdentifier: SwapiCell.reuseId)
        tableView.register(SpinnerCell.self, forCellReuseIdentifier: SpinnerCell.reuseIdSpinner)
        tableView.rowHeight = 80
    }
    
    func downloadCategories(page: Int) {
        guard let selectedCat = selectedCategory else { return }
        createSpinnerView()
        NetworkManager.shared.downloadResponse(urlCat: selectedCat.rawValue.lowercased(), page: page, responseType: CategoryResponseResults.self) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let categories):
                if categories.results.count < 10 { self.hasMoreList = false }
                DispatchQueue.main.async {
                    if self.categoryItem?.results.count == nil {
                        self.categoryItem = categories
                    } else {
                        self.categoryItem?.results.append(contentsOf: categories.results)
                    }
                    self.tableView.reloadData()
                    self.removeSpinner()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


extension ListVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 1:
            return 1
        default:
            guard let catItem = categoryItem else { return 0 }
            return catItem.results.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        
        switch section {
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: SpinnerCell.reuseIdSpinner, for: indexPath) as! SpinnerCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: SwapiCell.reuseId, for: indexPath) as! SwapiCell
            cell.labelCell.text = categoryItem?.results[indexPath.row].text
            cell.imageCell.image = selectedCategory?.labelForCategory
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return selectedCategory?.labelForList
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch section {
        case 1:
            return 0
        default:
            return 100
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreList else { return }
            page += 1
            downloadCategories(page: page)
        }
        
    }
    
}
