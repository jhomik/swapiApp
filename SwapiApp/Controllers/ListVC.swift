//
//  ListVC.swift
//  SwapiApp
//
//  Created by Jakub Homik on 13/02/2020.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import UIKit

//protocol FavoriteDelegateData: class {
//    func addDataToFavorite(_ textfield: String)
//}

class ListVC: UIViewController {
    
    var tableView: UITableView!
    var selectedCategory: Category?
    var categoryItem: CategoryResponseResults?
    var page = 1
    var hasMoreList = true
    let refreshControl = UIRefreshControl()
    var isRefreshingContent = true
//    weak var delegate: FavoriteDelegateData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTableView()
        downloadCategories(page: page)
        createRefreshControl()
        createNavBarButton()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = ""
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func createRefreshControl() {
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
    }
    
    @objc func refreshTableView() {
        page = 1
        isRefreshingContent = true
        downloadCategories(page: page)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func createNavBarButton() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addButtonTapped() {
        
        showAlertToAddText(title: "Add word", message: "", preferredStyle: .alert) { (string) in
            
            guard let text = string else { return }
//            self?.delegate?.addDataToFavorite(text)
            NotificationCenter.default.post(name: .didRecievedData, object: nil, userInfo: ["newText": text])
    
        }
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
        tableView = UITableView(frame: view.frame)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SwapiCell.self, forCellReuseIdentifier: SwapiCell.reuseId)
        tableView.register(UINib(nibName: "SpinnerCell", bundle: nil), forCellReuseIdentifier: "SpinnerCell")
        tableView.rowHeight = 80
    }
    
    func downloadCategories(page: Int) {
        guard let selectedCat = selectedCategory else { return }
        createSpinnerView()
        
        NetworkManager.shared.downloadResponse(urlCat: selectedCat.rawValue.lowercased(), page: page, responseType: CategoryResponseResults.self) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let categories):
                if categories.next == nil { self.hasMoreList = false }
                DispatchQueue.main.async {
                    
                    if self.categoryItem?.results.count == nil || self.isRefreshingContent {
                        self.categoryItem = categories
                        self.refreshControl.endRefreshing()
                        self.isRefreshingContent = false
                        self.hasMoreList = true
                    } else {
                        self.categoryItem?.results.append(contentsOf: categories.results)
                    }
                    self.tableView.reloadData()
                    self.removeSpinner()
                    
                }
            case .failure(let error):
                self.showAlert(title: "Ups", message: "Something wrong happend, try reconnect your internet. Error: \(error.localizedDescription)", preferredStyle: .alert) { [weak self] in
                    guard let self = self else { return }
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
    }
}


// MARK: TableView extension


extension ListVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 1:
            return self.hasMoreList ? 1 : 0
        default:
            guard let catItem = categoryItem else { return 0 }
            return catItem.results.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        
        switch section {
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SpinnerCell", for: indexPath) as! SpinnerCell
            cell.spinner.startAnimating()
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
        
        print(offsetY)
        print(contentHeight)
        print(height)
        
        if offsetY > contentHeight - height * 2 {
            guard hasMoreList else { return }
            page += 1
            downloadCategories(page: page)
        }
    }
}

