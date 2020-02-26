//
//  SpinnerCell.swift
//  SwapiApp
//
//  Created by Jakub Homik on 26/02/2020.
//  Copyright © 2020 Jakub Homik. All rights reserved.
//

import UIKit

class SpinnerCell: UITableViewCell {

    @IBOutlet weak var spinner: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
