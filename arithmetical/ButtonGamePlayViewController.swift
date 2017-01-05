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
    
    //Save the mapping between button tags and responses
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = self.game.name!
        self.correctLabel.text = String(self.correctResponses)
        self.presentQuestion()
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
            correctResponses += 1
            presentQuestion()
        } else {
            mainPromptLabel.shake()
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
