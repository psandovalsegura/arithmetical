//
//  ButtonGamePreviousQuestionCell.swift
//  arithmetical
//
//  Created by Pedro Sandoval on 1/6/17.
//  Copyright © 2017 Sandoval Software. All rights reserved.
//

import UIKit

class ButtonGamePreviousQuestionCell: UITableViewCell {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var lastQuestionLabel: UILabel!
    @IBOutlet weak var correctImageView: UIImageView!
    
    //Buttons
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
