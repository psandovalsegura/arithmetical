//
//  DragGamePlayViewController.swift
//  arithmetical
//
//  Created by Pedro Sandoval on 11/4/16.
//  Copyright © 2016 Sandoval Software. All rights reserved.
//

import UIKit

class DragGamePlayViewController: UIViewController {
    
    var game: DragGame!
    var option: String!
    var currentNumber: String!
    
    //Mark -- Timer
    var timer = Timer()
    var timerSeconds = Games.timerSeconds // 120 seconds = 2 minutes
    let timerDecrement = 1
    
    var correctResponses = 0
    var previousQuestions:[[String]] = []
    var studyQuestions: [[String]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = game.name!
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
