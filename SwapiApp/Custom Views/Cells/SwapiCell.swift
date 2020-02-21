//
//  SwapiCell.swift
//  SwapiApp
//
//  Created by Jakub Homik on 20/02/2020.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import UIKit

class SwapiCell: UITableViewCell {

    static let reuseId = "SwapiCell"
    
    let imageCell = SwapiImage(frame: .zero)
    let labelCell = SwapiLabel(textAlignment: .left, fontSize: 22)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        
        addSubview(imageCell)
        addSubview(labelCell)
        accessoryType = .disclosureIndicator
        imageCell.translatesAutoresizingMaskIntoConstraints = false
        labelCell.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageCell.widthAnchor.constraint(equalToConstant: 50),
            imageCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            imageCell.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageCell.heightAnchor.constraint(equalToConstant: 50),
            
            labelCell.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            labelCell.leadingAnchor.constraint(equalTo: imageCell.trailingAnchor, constant: 10),
            labelCell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            labelCell.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
