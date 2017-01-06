//
//  DragGamePlayViewController.swift
//  arithmetical
//
//  Created by Pedro Sandoval on 11/4/16.
//  Copyright © 2016 Sandoval Software. All rights reserved.
//

import UIKit

class DragGamePlayViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var checkmarkImageView: UIImageView!
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var trayView: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    var game: DragGame!
    var option: String!
    var currentNumber: String!
    var progressSeparator = "・"
    var progress: [Int: Int] = [2:0, 3:0, 5:0, 7:0, 11:0] //Maintain count of exponent (value) on base (key)
    var draggableItems = [Int]() //Maintains order of dragged items
    var mistakes: Int = 0
    
    //Mark -- Timer
    var timer = Timer()
    var timerSeconds = Games.timerSeconds // 120 seconds = 2 minutes
    let timerDecrement = 1
    
    var correctResponses = 0 {
        didSet {
            self.correctLabel.text = String(correctResponses)
        }
    }
    
    var previousQuestions:[[String]] = []
    var studyQuestions: [[String]] = []

    var mainNumber: Int? {
        didSet {
            self.mainNumberLabel.text = String(mainNumber!)
        }
    }
    
    @IBOutlet weak var mainNumberLabel: UILabel!
    var newPrime: UILabel!
    var mainNumberScale = 1.0
    
    
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
        } else {
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
        //The number generator ensures the number is composite
        self.mainNumber = self.game.mainNumberGenerator()
        self.currentNumber = String(self.mainNumber!)
    }

    func validateAnswer() -> Bool {
        if self.mainNumber! % Int(self.newPrime.text!)! == 0 {
            let validPrime = Int(self.newPrime.text!)!
            if !self.draggableItems.contains(validPrime) {
                self.draggableItems.append(validPrime)
            }
            updateProgressLabel(item: validPrime)
            return true
        }
        return false
    }
    
    func updateProgressLabel(item: Int) {
        //Update the progress dictionary and current factoring
        self.progress[item]! += 1
        self.progressLabel.text = makeExponentString(progress: self.progress, draggableItems: self.draggableItems, separator: self.progressSeparator)
    }
    
    func makeExponentString(progress: [Int:Int], draggableItems: [Int], separator: String) -> String {
        
        let supers = [
            "2": "\u{00B2}",
            "3": "\u{00B3}",
            "4": "\u{2074}",
            "5": "\u{2075}",
            "6": "\u{2076}",
            "7": "\u{2077}",
            "8": "\u{2078}",
            "9": "\u{2079}"]
        
        var newStr = ""
        for prime in draggableItems {
            if progress[prime]! > 0 {
                let superscript = String(describing: progress[prime]!)
                newStr.append(String(describing: prime))
                if supers.keys.contains(superscript) {
                    newStr.append(Character(supers[superscript]!))
                }
                newStr.append(separator)
            }
        }
        
        //Remove the last character if it is a separator
        if newStr[newStr.index(before: newStr.endIndex)] == Character(separator) {
            newStr = newStr.substring(to: newStr.index(before: newStr.endIndex))
        }
        
        
        return newStr
    }
    
    //Deprecated
    func isPrime(number: Int) -> Bool {
        //Check numbers up to the square root of the number
        
        var check: Int = 2
        while Double(check) <= round(pow(Double(number), 0.5)) {
            if number % check == 0 {
                return false
            }
            check += 1
        }
        
        return true
    }
    
    @IBAction func didPanPrime(_ sender: UIPanGestureRecognizer) {
        let createdPrime = sender.view as! UILabel
        let translation = sender.translation(in: self.view)
        
        switch sender.state {
        case .began:
            //Create and configure the new label
            self.newPrime = UILabel()
            self.newPrime.text = createdPrime.text!
            self.newPrime.frame = createdPrime.frame
            self.newPrime.center = createdPrime.center
            self.newPrime.font = createdPrime.font
            self.newPrime.textColor = createdPrime.textColor
            
            //Add the new label to the view, for dragging
            self.view.addSubview(self.newPrime)
            self.newPrime.center = createdPrime.center
            UIView.animate(withDuration: 0.1, animations: {
                self.newPrime.transform = CGAffineTransform(scaleX: 2, y: 2)
            }, completion: { (done) in
                //
            })
            
            
        case .changed:
            self.newPrime.center = CGPoint(x: createdPrime.center.x + translation.x, y: createdPrime.center.y + translation.y)

        case .ended:
            //Check if drop is valid
            if !self.validPrimePosition() {
                //Invalid drag position
                self.newPrime.removeFromSuperview()
            } else if !validateAnswer() {
                //Invalid answer
                self.mainNumberLabel.shake()
                self.mistakes += 1
                animatePrimeFalling()
            } else {
                //Update the main number
                self.mainNumberScale -= 0.1
                self.mainNumber = self.mainNumber! / Int(self.newPrime.text!)!
                
                //Check if the number has been completely factored
                if self.mainNumber == 1 {
                    //Factoring complete: reset the main number label scale
                    animateCorrectCheckmark()
                    saveToPreviousQuestions()
                    studyCheck()
                    correctResponses += 1
                    resetView()
                    self.presentQuestion()
                } else {
                    //More primes necessary: the number shrinks
                    UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 10, options: [], animations: {
                        self.mainNumberLabel.transform = CGAffineTransform(scaleX: CGFloat(self.mainNumberScale), y: CGFloat(self.mainNumberScale))
                    }, completion: { (done) in
                        //
                    })
                    
                }
                
                animatePrimeFalling()
            }
            
        default:
            print("default")
        }
    }
    
    func animateCorrectCheckmark() {
        
        UIView.animate(withDuration: 1.0, animations: {
            self.checkmarkImageView.isHidden = false
            self.checkmarkImageView.alpha = 0.0
        }, completion: { (finished) in
            self.checkmarkImageView.isHidden = true
            self.checkmarkImageView.alpha = 1.0
        })
    }
    
    //Save the current, correctly answered question to the previousQuestions array
    func saveToPreviousQuestions() {
        //Append to the beginning of the questions array  - questions are string arrays of the format [<current number>, <factoring>]
        self.previousQuestions.insert([self.currentNumber, self.progressLabel.text!], at: 0)
    }
    
    //Check if the current question should be saved in the studyQuestions array
    func studyCheck() {
        if self.mistakes > 0 {
            saveToStudyQuestions()
        }
    }
    
    //Save the correctly answered question to the studyQuestions array
    func saveToStudyQuestions() {
        //Append to the beginning of the study array  - questions are string arrays of the format [<current number>, <factoring>, <mistakes>]
        self.studyQuestions.insert([self.currentNumber, self.progressLabel.text!, String(self.mistakes)], at: 0)
    }
    
    func animateFactoringLabel() {
        UIView.animate(withDuration: 1.0, animations: {
            self.progressLabel.alpha = 0.0
        }, completion: {(finished) in
            self.progressLabel.text = nil
            self.progressLabel.alpha = 1.0
        })
    }
    
    func resetView() {
        self.mainNumberScale = 1
        resetProgress()
        
        //Clear the progress label and reset the size of the main label
        animateFactoringLabel()
        UIView.animate(withDuration: 0.2, animations: {
            self.mainNumberLabel.transform = CGAffineTransform(scaleX: CGFloat(self.mainNumberScale), y: CGFloat(self.mainNumberScale))
        })
    }
    
    func resetProgress() {
        for prime in draggableItems {
            self.progress[prime] = 0
        }
        self.draggableItems = [Int]()
        self.mistakes = 0
    }
    
    //Animates a falling prime and also removes it from view
    func animatePrimeFalling() {
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {
            self.newPrime.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.newPrime.alpha = 0.0
        }, completion: { (done) in
            self.newPrime.removeFromSuperview()
        })
    }
    
    //Returns true if position is valid (above tray), false otherwise
    func validPrimePosition() -> Bool {
        if self.newPrime.center.y >= self.trayView.frame.minY {
            return false
        } else {
            return true
        }
    }
    
    func timerUpdate() {
        if self.timerSeconds == 0 {
            timer.invalidate()
            
            //Add the final, unanswered question to the study array - find way for computer to factor simply
            //saveToStudyQuestions()
            
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
