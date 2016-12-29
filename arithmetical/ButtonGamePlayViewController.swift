//
//  ButtonGamePlayViewController.swift
//  arithmetical
//
//  Created by Pedro Sandoval on 12/28/16.
//  Copyright © 2016 Sandoval Software. All rights reserved.
//

import UIKit

class ButtonGamePlayViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var mainPromptLabel: UILabel!
    @IBOutlet weak var checkmarkImageView: UIImageView!
    
    var game: ButtonGame!
    var option: String!
    
    //Mark -- Timer
    var timer = Timer()
    var timerSeconds = Games.timerSeconds // 120 seconds = 2 minutes
    let timerDecrement = 1
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
