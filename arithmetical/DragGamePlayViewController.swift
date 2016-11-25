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

    var mainNumber: Int?
    @IBOutlet weak var mainNumberLabel: UILabel!
    var newPrime: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = game.name!
        
        // Do any additional setup after loading the view.
        self.presentQuestion()
    }
    
    func presentQuestion() {
        
        self.mainNumber = self.game.mainNumberGenerator()
        self.mainNumberLabel.text = String(self.mainNumber!)
        
    }

    func validateAnswer() {
        
    }
    
    @IBAction func didPanPrime(_ sender: UIPanGestureRecognizer) {
        var createdPrime = sender.view as! UILabel
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
            
            //Add the new label to the view
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
                self.newPrime.removeFromSuperview()
            } else {
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {
                    self.newPrime.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion: { (done) in
                    //
                })
            }
            
        default:
            print("default")
        }
    }
    
    //Returns true if position is valid (above tray), false otherwise
    func validPrimePosition() -> Bool {
        if self.newPrime.center.y >= 450 {
            return false
        } else {
            return true
        }
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
