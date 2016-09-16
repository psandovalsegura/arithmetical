//
//  AnswerGamePlayViewController.swift
//  arithmetical
//
//  Created by Pedro Sandoval on 8/29/16.
//  Copyright © 2016 Sandoval Software. All rights reserved.
//

import UIKit

class AnswerGamePlayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var checkmarkImageView: UIImageView!
    
    var game: AnswerGame!
    var option: String!
    var currentQuestion: String!
    
    //Mark -- Timer
    var timer = Timer()
    var timerSeconds = 120 // 120 seconds = 2 minutes
    let timerDecrement = 1
    
    var correctResponses = 0
    var previousQuestions:[[String]] = []
    var studyQuestions: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = game.name!
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.checkmarkImageView.isHidden = true
        textField.becomeFirstResponder()
        
        self.presentQuestion()

        if self.option == "timed" {
            // Start the timer
            timer = Timer.scheduledTimer(timeInterval: Double(self.timerDecrement), target: self, selector: #selector(ArithmeticGamePlayViewController.timerUpdate), userInfo: nil, repeats: true )
            timerUpdate()
            
            //Remove the study up section of the segemented control
            self.segmentedControl.removeSegment(at: 1, animated: true)
            self.segmentedControl.isHidden = true
            
        } else if self.option == "unlimited" {
            //Hide timer label
            self.timerLabel.isHidden = true
        }
    
    }

    @IBAction func onInputChange(_ sender: AnyObject) {
        if (textField.text != "" && textField.text != nil) && validateAnswer() {
            //The user input was correct - clear field for next question
            textField.text = nil
            presentQuestion()
        }
    }
    
    func presentQuestion() {
        self.currentQuestion = self.game.questionGenerator()
        self.questionLabel.text = self.currentQuestion
        
        //Update the correct count label
        self.correctLabel.text = String(correctResponses)
    }
    
    func validateAnswer() -> Bool{
        if String(Int(self.textField.text!)!, radix: 2) == self.currentQuestion {
            
            self.previousQuestions.insert([self.currentQuestion, self.textField.text!], at: 0)
            
            //Animate the new cell that has been added to the Previous Questions
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: UITableViewRowAnimation.top)
            
            self.correctResponses += 1
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
            textField.isEnabled = false
            
            //Segue to end game
            self.performSegue(withIdentifier: "answerGameEndSegue", sender: nil)
        }
        
        self.timerLabel.text = Games.stringFromTimeInterval(self.timerSeconds) as String
        self.timerSeconds -= self.timerDecrement
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.previousQuestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "answerCell") as! AnswerGamePreviousQuestionCell
        
        let previousQuestion = self.previousQuestions[(indexPath as NSIndexPath).row]
        cell.questionLabel.text = previousQuestion[0]
        cell.answerLabel.text = previousQuestion[1]
        
        return cell
    }
    
    func animateCorrectCheckmark() {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.checkmarkImageView.isHidden = false
            self.checkmarkImageView.alpha = 0.0
        }, completion: { (finished) in
            self.checkmarkImageView.isHidden = true
            self.checkmarkImageView.alpha = 1.0
        }) 
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let endGameVC = segue.destination as? AnswerGameEndViewController {
            //endGameVC.studyQuestions = self.studyQuestions
            //endGameVC.correctResponses = self.correctResponses
        }
    }
    

}
