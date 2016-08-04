//
//  InGameViewController.swift
//  arithmetical
//
//  Created by Pedro Sandoval Segura on 8/4/16.
//  Copyright © 2016 Sandoval Software. All rights reserved.
//

import UIKit

class InGameViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var number1Label: UILabel!
    @IBOutlet weak var number2Label: UILabel!
    @IBOutlet weak var operationLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var game: Game?
    var timer = NSTimer()
    let timerLimit = 120 // 120 seconds = 2 minutes
    let timerIncrement = 1
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = game!.name!
        
        textField.becomeFirstResponder()
        
        //self.presentQuestion()
        
        // Start the timer
        timer = NSTimer.scheduledTimerWithTimeInterval(Double(self.timerIncrement), target: self, selector: #selector(InGameViewController.timerUpdate), userInfo: nil, repeats: true )
        
    }

    
    @IBAction func onInputChange(sender: AnyObject) {
        
    }
    
    func timerUpdate() {
        if counter == timerLimit {
            timer.invalidate()
            textField.resignFirstResponder()
        }
        
        self.timerLabel.text = String(self.counter)
        counter += self.timerIncrement
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
