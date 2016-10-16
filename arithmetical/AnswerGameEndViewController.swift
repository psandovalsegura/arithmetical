//
//  AnswerGameEndViewController.swift
//  arithmetical
//
//  Created by Pedro Sandoval on 9/1/16.
//  Copyright © 2016 Sandoval Software. All rights reserved.
//

import UIKit

class AnswerGameEndViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var newHighscoreLabel: UILabel!
    @IBOutlet weak var correctResponsesLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //Data Fields
    var studyQuestions: [[String]]?
    var correctResponses: Int?
    var game: AnswerGame!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.correctResponsesLabel.text = String(correctResponses!)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkScore()
    }

    func checkScore() {
        //Check if this is a new highscore
        let previousHighscore = UserDefaults.standard.integer(forKey: "\(self.game.name!)_highscore")
        
        if (correctResponses! > previousHighscore) {
            self.newHighscoreLabel.isHidden = false
            getPlayerName(completion: { (name) in
                var highscoreArray = [String]()
                highscoreArray.append(String(self.correctResponses!))
                highscoreArray.append(name)
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
            textField.text = "SS 2016"
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
        return 0 //(self.studyQuestions?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "answerCell") as! AnswerGamePreviousQuestionCell
        let question = self.studyQuestions![(indexPath as NSIndexPath).row]
        cell.questionLabel.text = question[1]
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
