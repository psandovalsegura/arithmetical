//
//  TopScoresTableViewCell.swift
//  arithmetical
//
//  Created by Pedro Sandoval on 9/16/16.
//  Copyright © 2016 Sandoval Software. All rights reserved.
//

import UIKit

class TopScoresTableViewCell: UITableViewCell {

    @IBOutlet weak var highScore: UILabel!
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var gameImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
