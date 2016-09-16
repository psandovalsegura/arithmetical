//
//  AnswerGamePreviousQuestionCell.swift
//  arithmetical
//
//  Created by Pedro Sandoval on 9/1/16.
//  Copyright © 2016 Sandoval Software. All rights reserved.
//

import UIKit

class AnswerGamePreviousQuestionCell: UITableViewCell {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
