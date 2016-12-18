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
    @IBOutlet weak var checkmarkImageView: UIImageView!
    @IBOutlet weak var correctLabel: UILabel!
    
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
        self.title = game.name!
        
        // Do any additional setup after loading the view.
        self.correctLabel.text = String(self.correctResponses)
        self.presentQuestion()
    }
    
    
    
    func presentQuestion() {
        //Ensure the number is composite
        self.mainNumber = self.game.mainNumberGenerator()
    }

    func validateAnswer() -> Bool {
        if self.mainNumber! % Int(self.newPrime.text!)! == 0 {
            return true
        }
        return false
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
                self.newPrime.removeFromSuperview()
            } else if !validateAnswer() {
                self.mainNumberLabel.shake()
                animatePrimeFalling()
            } else {
                //Update the main number
                self.mainNumberScale -= 0.1
                self.mainNumber = self.mainNumber! / Int(self.newPrime.text!)!
                
                //Check if the number has been completely factored
                if self.mainNumber == 1 {
                    animateCorrectCheckmark()
                    correctResponses += 1
                    resetView()
                    self.presentQuestion()
                } else {
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
        
        UIView.animate(withDuration: 0.5, animations: {
            self.checkmarkImageView.isHidden = false
            self.checkmarkImageView.alpha = 0.0
        }, completion: { (finished) in
            self.checkmarkImageView.isHidden = true
            self.checkmarkImageView.alpha = 1.0
        })
    }
    
    func resetView() {
        self.mainNumberScale = 1
        UIView.animate(withDuration: 0.2, animations: {
            self.mainNumberLabel.transform = CGAffineTransform(scaleX: CGFloat(self.mainNumberScale), y: CGFloat(self.mainNumberScale))
        })
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

extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.4
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}
