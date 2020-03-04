//
//  ViewController+Ext.swift
//  SwapiApp
//
//  Created by Jakub Homik on 27/02/2020.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let actionVC = UIAlertAction(title: "Go back", style: .default) { action in
                self.navigationController?.popToRootViewController(animated: true)
            }
            
            alertVC.addAction(actionVC)
            
            self.present(alertVC, animated: true) {
                print("test2")
            }
        }
    }
}


