//
//  GameTableViewCell.swift
//  arithmetical
//
//  Created by Pedro Sandoval Segura on 8/4/16.
//  Copyright © 2016 Sandoval Software. All rights reserved.
//

import UIKit

class GameTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
