//
//  SwapiImage.swift
//  SwapiApp
//
//  Created by Jakub Homik on 20/02/2020.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import UIKit

class SwapiImage: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        }
    }
