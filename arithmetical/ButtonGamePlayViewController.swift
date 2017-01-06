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
    @IBOutlet weak var correctCircleImageView: UIImageView!
    
    var game: ButtonGame!
    var option: String!
    var previousQuestions:[[String]] = []
    var studyQuestions: [[String]] = []
    var mistakes = 0 // There is initially no mistakes for the first question
    
    //Mark -- Timer
    var timer = Timer()
    var timerSeconds = Games.timerSeconds // 120 seconds = 2 minutes
    let timerDecrement = 1
    
    var correctResponses = 0 {
        didSet {
            self.correctLabel.text = String(correctResponses)
        }
    }
    
    var currentPrompt: String? {
        didSet {
            self.mainPromptLabel.text = currentPrompt!
        }
    }
    
    var correctTap: Int? // A button tag
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = self.game.name!
        self.correctLabel.text = String(self.correctResponses)
        self.presentQuestion()
        
        if self.option == "timed" {
            // Start the timer
            timer = Timer.scheduledTimer(timeInterval: Double(self.timerDecrement), target: self, selector: #selector(ArithmeticGamePlayViewController.timerUpdate), userInfo: nil, repeats: true )
            timerUpdate()
        } else if self.option == "unlimited" {
            //Hide timer label
            self.timerLabel.isHidden = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        if timer.isValid {
            timer.invalidate()
        }
    }
    
    func presentQuestion() {
        self.currentPrompt = self.game.mainPromptGenerator()
        self.correctTap = self.game.selectionDictionary[self.currentPrompt!]
    }
    
    func validButtonTap(tag: Int) {
        if tag == self.correctTap {
            animateCorrectCheckmark()
            saveToPreviousQuestions()
            correctResponses += 1
            presentQuestion()
        } else {
            mainPromptLabel.shake()
            self.mistakes += 1
        }
    }
    
    @IBAction func onButtonTap(_ sender: UIButton) {
       validButtonTap(tag: sender.tag)
    }
    
    func animateCorrectCheckmark() {
        
        UIView.animate(withDuration: 1.0, animations: {
            self.checkmarkImageView.isHidden = false
            self.checkmarkImageView.alpha = 0.0
            
            self.correctCircleImageView.isHidden = false
            self.correctCircleImageView.alpha = 0.0
        }, completion: { (finished) in
            self.checkmarkImageView.isHidden = true
            self.checkmarkImageView.alpha = 1.0
            
            self.correctCircleImageView.isHidden = true
            self.correctCircleImageView.alpha = 1.0
        })
    }
    
    //Save the current, correctly answered question to the previousQuestions array
    func saveToPreviousQuestions() {
        //Append to the beginning of the questions array  - questions are string arrays of the format [<question>, <correct tag>]
        self.previousQuestions.insert([self.currentPrompt!, String(describing: Int(self.correctTap!))], at: 0)
        
        if self.mistakes > 0 {
            saveToStudyQuestions()
        }
        
        self.mistakes = 0 // Reset
    }
    
    //Save the correctly answered question to the studyQuestions array
    func saveToStudyQuestions() {
        //Append to the beginning of the study array  - questions are string arrays of the format [<question>, <correct tap>, <mistakes>]
        self.studyQuestions.insert([self.currentPrompt!, String(describing: Int(self.correctTap!)), String(self.mistakes)], at: 0)
    }

    func timerUpdate() {
        
        if self.timerSeconds == 0 {
            timer.invalidate()
            
            //Add the final, unanswered question to the study array
            saveToStudyQuestions()
            
            //Segue to end game
            self.performSegue(withIdentifier: "endGameSegue", sender: nil)
        }
        
        self.timerLabel.text = Game.stringFromTimeInterval(self.timerSeconds) as String
        self.timerSeconds -= self.timerDecrement
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let endGameVC = segue.destination as? GameEndViewController {
            endGameVC.studyQuestions = self.studyQuestions
            endGameVC.correctResponses = self.correctResponses
            endGameVC.game = game
        }
    }
    

}
