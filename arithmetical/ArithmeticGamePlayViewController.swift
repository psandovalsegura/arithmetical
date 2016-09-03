//
//  ArithmeticGamePlayViewController.swift
//  arithmetical
//
//  Created by Pedro Sandoval Segura on 8/4/16.
//  Copyright © 2016 Sandoval Software. All rights reserved.
//

import UIKit

class ArithmeticGamePlayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var number1Label: UILabel!
    @IBOutlet weak var number2Label: UILabel!
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var operationLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var checkmarkImageView: UIImageView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var game: ArithmeticGame!
    var option: String!
    var currentNumber1: Int!
    var currentNumber2: Int!
    
    //Mark -- Timer
    var timer = NSTimer()
    var timerSeconds = 120 // 120 seconds = 2 minutes
    let timerDecrement = 1
    
    var correctResponses = 0
    var previousQuestions:[[String]] = []
    var studyQuestions: [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = game.name!
        self.checkmarkImageView.hidden = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
        setupOperationLabel()
        textField.becomeFirstResponder()
        
        self.presentQuestion()
        
        if self.option == "timed" {
            // Start the timer
            timer = NSTimer.scheduledTimerWithTimeInterval(Double(self.timerDecrement), target: self, selector: #selector(ArithmeticGamePlayViewController.timerUpdate), userInfo: nil, repeats: true )
            timerUpdate()
            
            //Remove the study up section of the segemented control
            self.segmentedControl.removeSegmentAtIndex(1, animated: true)
            self.segmentedControl.hidden = true
            
        } else if self.option == "unlimited" {
            //Hide timer label
            self.timerLabel.hidden = true
        }
        
    }

    
    @IBAction func onInputChange(sender: AnyObject) {
        if (textField.text != "" && textField.text != nil) && validateAnswer() {
            //The user input was correct - clear field for next question
            textField.text = nil
            presentQuestion()
        }
    }
    
    func presentQuestion() {
        
        self.currentNumber1 = self.game.number1generation()
        self.currentNumber2 = self.game.number2generation()
        
        number1Label.text = String(self.currentNumber1)
        number2Label.text = String(self.currentNumber2)
        
        //Update the correct count label
        self.correctLabel.text = String(correctResponses)
    }
    
    func validateAnswer() -> Bool {
        if game.operation(self.currentNumber1, self.currentNumber2) == Int(textField.text!) {
            self.previousQuestions.insert([String(self.currentNumber1), self.operationLabel.text!, String(self.currentNumber2), self.textField.text!], atIndex: 0) //append to the beginning of the questions array  - questions are string arrays of the format [<number1>, <operator>, <number2>, <answer>]
            
            //Animate the new cell that has been added to the Previous Questions
            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
            
            correctResponses += 1
            animateCorrectCheckmark()
            return true
        } else {
            return false
        }
    }
    
    func timerUpdate() {
        if self.timerSeconds == 0 {
            timer.invalidate()
            textField.resignFirstResponder()
            textField.enabled = false
            
            //Segue to end game
            self.performSegueWithIdentifier("arithmeticGameEndSegue", sender: nil)
        }
        
        self.timerLabel.text = Games.stringFromTimeInterval(self.timerSeconds) as String
        self.timerSeconds -= self.timerDecrement
        
    }
    
    func setupOperationLabel() {
        if game.operation(50, 5) == 55 {
            self.operationLabel.text = "+"
        } else if game.operation(50, 5) == 45 {
            self.operationLabel.text = "-"
        } else if game.operation(50, 5) == 250 {
            self.operationLabel.text = "x"
        } 
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.previousQuestions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("arithmeticCell") as! ArithmeticGamePreviousQuestionCell
        cell.operationLabel.text = self.operationLabel.text
        
        let previousQuestion = self.previousQuestions[indexPath.row]
        cell.number1Label.text = previousQuestion[0]
        cell.number2Label.text = previousQuestion[2]
        cell.answerLabel.text = previousQuestion[3]
        
        return cell
    }

    func animateCorrectCheckmark() {
        
        UIView.animateWithDuration(0.5, animations: {
            self.checkmarkImageView.hidden = false
            self.checkmarkImageView.alpha = 0.0
        }) { (finished) in
            self.checkmarkImageView.hidden = true
            self.checkmarkImageView.alpha = 1.0
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let endGameVC = segue.destinationViewController as? ArithmeticGameEndViewController {
            endGameVC.studyQuestions = self.studyQuestions
            endGameVC.correctResponses = self.correctResponses
        }
    }
    

}
