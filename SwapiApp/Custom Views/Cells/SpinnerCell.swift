//
//  SpinnerCell.swift
//  SwapiApp
//
//  Created by Jakub Homik on 24/02/2020.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import UIKit

class SpinnerCell: UITableViewCell {
    
    static let reuseIdSpinner = "SpinnerCell"
    
    let spinner = UIActivityIndicatorView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSpinnerView() {
        
        let ai = UIActivityIndicatorView(style: .large)
        ai.center = contentView.center
        ai.accessibilityIdentifier = "Spinner"
        ai.startAnimating()
        DispatchQueue.main.async {
            self.addSubview(ai)
        }
    }
    
    func removeSpinner() {
        guard let ai = subviews.first(where: {$0 is UIActivityIndicatorView && $0.accessibilityIdentifier == "Spinner" }) else { return }
        DispatchQueue.main.async {
            ai.removeFromSuperview()
        }
    }
}
