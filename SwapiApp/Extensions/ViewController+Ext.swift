//
//  ViewController+Ext.swift
//  SwapiApp
//
//  Created by Jakub Homik on 27/02/2020.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, preferredStyle: UIAlertController.Style, closure: @escaping () -> Void) {
        DispatchQueue.main.async {
            
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
            let actionVC = UIAlertAction(title: "Go back", style: .default) { (action) in
                closure()
            }
            
            alertVC.addAction(actionVC)
    
            self.present(alertVC, animated: true)
        }
    }
    
    func showAlertToAddText(title: String, message: String, preferredStyle: UIAlertController.Style, closure: @escaping () -> Void) {
        DispatchQueue.main.async {
            
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
            alertVC.addTextField()
            let actionVC = UIAlertAction(title: "Add", style: .default) { (action) in
                closure()
            }
            
            alertVC.addAction(actionVC)
            self.present(alertVC, animated: true)
        }
    }
    
}
