//
//  ArithmeticGamePreviousQuestionCell.swift
//  arithmetical
//
//  Created by Pedro Sandoval on 8/26/16.
//  Copyright © 2016 Sandoval Software. All rights reserved.
//

import UIKit

class ArithmeticGamePreviousQuestionCell: UITableViewCell {
    
    @IBOutlet weak var number1Label: UILabel!
    @IBOutlet weak var number2Label: UILabel!
    @IBOutlet weak var operationLabel: UILabel!
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
