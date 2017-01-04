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
    @IBOutlet weak var timedButton: UIButton!
    @IBOutlet weak var unlimitedButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        gameImageView.contentMode = UIViewContentMode.scaleAspectFit
        
        // Check that the GameTableView cell contains the buttons (is of identifier "selectedGameCell")
        if timedButton != nil && unlimitedButton != nil {
    
            self.timedButton.layer.cornerRadius = 10
            self.timedButton.layer.borderWidth = 1
            self.timedButton.layer.borderColor = UIColor.white.cgColor
            self.unlimitedButton.layer.cornerRadius = 10
            self.unlimitedButton.layer.borderWidth = 1
            self.unlimitedButton.layer.borderColor = UIColor.white.cgColor

        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
