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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

