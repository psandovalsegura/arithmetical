//
//  ArithmeticGameEndViewController.swift
//  arithmetical
//
//  Created by Pedro Sandoval on 8/26/16.
//  Copyright © 2016 Sandoval Software. All rights reserved.
//

import UIKit

class ArithmeticGameEndViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var newHighscoreLabel: UILabel!
    @IBOutlet weak var correctResponsesLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //Data Fields
    var studyQuestions: [[String]]?
    var correctResponses: Int?
    var game: ArithmeticGame?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.correctResponsesLabel.text = String(correctResponses!)
        checkScore()
        
        // Do any additional setup after loading the view.
    }
    
    func checkScore() {
        //Check if this is a new highscore
        let previousHighscore = UserDefaults.standard.integer(forKey: "\(self.game!.name)_highscore")
        
        if (correctResponses! > previousHighscore) {
            self.newHighscoreLabel.isHidden = false
            UserDefaults.standard.set(correctResponses!, forKey: "\(self.game!.name)_highscore")
            
        }
        else {
            self.newHighscoreLabel.isHidden = true
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.studyQuestions?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "arithmeticCell") as! ArithmeticGamePreviousQuestionCell
        let question = self.studyQuestions![(indexPath as NSIndexPath).row]
        cell.number1Label.text = question[0]
        cell.operationLabel.text = question[1]
        cell.number2Label.text = question[2]
        cell.answerLabel.text = question[3]
        
        return cell
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
