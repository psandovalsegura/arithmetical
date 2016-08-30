//
//  AnswerGamePlayViewController.swift
//  arithmetical
//
//  Created by Pedro Sandoval on 8/29/16.
//  Copyright © 2016 Sandoval Software. All rights reserved.
//

import UIKit

class AnswerGamePlayViewController: UIViewController { //, UITableViewDelegate, UITableViewDataSource
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var game: AnswerGame!
    var option: String!
    var currentQuestion: String!
    
    //Mark -- Timer
    var timer = NSTimer()
    let timerLimit = 120 // 120 seconds = 2 minutes
    let timerIncrement = 1
    var counter = 0
    
    var correctResponses = 0
    var previousQuestions:[[String]] = []
    var studyQuestions: [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = game.name!
        //self.tableView.delegate = self
        //self.tableView.dataSource = self
        textField.becomeFirstResponder()
        
        self.presentQuestion()
        
        // Start the timer
        timer = NSTimer.scheduledTimerWithTimeInterval(Double(self.timerIncrement), target: self, selector: #selector(ArithmeticGamePlayViewController.timerUpdate), userInfo: nil, repeats: true )
    }

    @IBAction func onInputChange(sender: AnyObject) {
        if (textField.text != "" && textField.text != nil) && validateAnswer() {
            //The user input was correct - clear field for next question
            textField.text = nil
            presentQuestion()
        }
    }
    
    func presentQuestion() {
        //testing
        self.questionLabel.text = "2020"
    }
    
    func validateAnswer() -> Bool{
        //testing
        return true
    }
    
    func timerUpdate() {
        if counter == timerLimit {
            timer.invalidate()
            textField.resignFirstResponder()
            textField.enabled = false
            
            //Segue to end game
            self.performSegueWithIdentifier("answerGameEndSegue", sender: nil)
        }
        
        self.timerLabel.text = String(self.counter)
        counter += self.timerIncrement
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let endGameVC = segue.destinationViewController as? GameEndViewController {
            endGameVC.studyQuestions = self.studyQuestions
            endGameVC.correctResponses = self.correctResponses
        }
    }
    

}
