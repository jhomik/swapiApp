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
            guard self.isViewLoaded else { return }
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        newObserver()
    }
    
    func configureTableView() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Favorites")
        
    }
    
    func newObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(wordAdded), name: .didRecievedData, object: nil)
    }
    
    @objc func wordAdded(_ notification: Notification) {
        
        guard let newText = notification.userInfo?["newText"] as? String else { return }
        
            list.append(newText)
            print(newText)
            
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

extension Notification.Name {
    static let didRecievedData = Notification.Name(rawValue: "didRecievedData")
}
