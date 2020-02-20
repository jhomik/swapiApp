//
//  SwapiLabel.swift
//  SwapiApp
//
//  Created by Jakub Homik on 20/02/2020.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import UIKit

class SwapiLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .semibold)
        configure()
    }
    
    func configure() {
        textColor = .label
        adjustsFontSizeToFitWidth = true
        translatesAutoresizingMaskIntoConstraints = false
    }

}
