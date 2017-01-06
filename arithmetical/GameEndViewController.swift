//
//  GameEndViewController.swift
//  arithmetical
//
//  Created by Pedro Sandoval on 1/4/17.
//  Copyright © 2017 Sandoval Software. All rights reserved.
//

import UIKit

class GameEndViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var newHighscoreLabel: UILabel!
    @IBOutlet weak var correctResponsesLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    //Data Fields
    var studyQuestions: [[String]]!
    var correctResponses: Int!
    var game: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.correctResponsesLabel.text = String(correctResponses)
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkScore()
    }
    
    func checkScore() {
        //Default previous highscore
        var previousHighscore = 0
        
        //Check if this is a new highscore
        if let highscoreArray = UserDefaults.standard.stringArray(forKey: "\(self.game.name!)_highscore") {
            previousHighscore = Int(highscoreArray[0])!
        }
        
        if (correctResponses > previousHighscore) {
            self.newHighscoreLabel.isHidden = false
            getPlayerName(completion: { (name) in
                var highscoreArray = [String]()
                highscoreArray.append(String(self.correctResponses))
                highscoreArray.append(name)
                User.saveName(name: name)
                UserDefaults.standard.set(highscoreArray, forKey: "\(self.game.name!)_highscore")
            })
        } else {
            self.newHighscoreLabel.isHidden = true
        }
    }
    
    func getPlayerName(completion: @escaping (String) -> Void) {
        let alert = UIAlertController(title: "New Highscore!", message: "What's your name?", preferredStyle: .alert)
        
        //Add text field
        alert.addTextField { (textField) in
            textField.text = User.getName()
        }
        
        //Get player name from text field
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (_) in
            let textField = alert.textFields![0] // Force unwrapping because we know it exists.
            completion(textField.text!)
        }))
        
        //Present alert input field
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.studyQuestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let question = self.studyQuestions[indexPath.row]
        
        let createCell = { () -> UITableViewCell in
            if ((self.game as? ArithmeticGame) != nil) {
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "arithmeticCell") as! ArithmeticGamePreviousQuestionCell
                cell.number1Label.text = question[0]
                cell.operationLabel.text = question[1]
                cell.number2Label.text = question[2]
                cell.answerLabel.text = question[3]
                
                //Denote the last question
                if indexPath.row == 0 {
                    cell.lastQuestionLabel.isHidden = false
                }
                
                return cell
                
            } else if ((self.game as? AnswerGame) != nil) {
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "answerCell") as! AnswerGamePreviousQuestionCell
                cell.questionLabel.text = question[0]
                cell.answerLabel.text = question[1]
                
                //Denote the last question
                if indexPath.row == 0 {
                    cell.lastQuestionLabel.isHidden = false
                }
                
                return cell
            } else if ((self.game as? DragGame) != nil) {
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "answerCell") as! AnswerGamePreviousQuestionCell
                cell.questionLabel.text = question[0]
                cell.answerLabel.text = question[1]
                
                //Denote the last question, somehow
                
                return cell
            } else if ((self.game as? ButtonGame) != nil) {
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "buttonCell") as! ButtonGamePreviousQuestionCell
                
                cell.questionLabel.text = question[0]
                cell.correctImageView.image = UIImage(named: "unitCircle_\(question[1])")
                //Denote the last question
                if indexPath.row == 0 {
                    cell.lastQuestionLabel.isHidden = false
                }
                
                return cell
            }
            
            //Default
            return UITableViewCell()
        }
        
        return createCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if ((self.game as? ArithmeticGame) != nil) {
            return 85
        } else if ((self.game as? AnswerGame) != nil) {
            return 85
        } else if ((self.game as? DragGame) != nil) {
            return 85
        } else if ((self.game as? ButtonGame) != nil) {
            return 161
        }
        
        //Default 
        return 85
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
