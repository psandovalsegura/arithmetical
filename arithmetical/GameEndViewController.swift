//
//  GameEndViewController.swift
//  arithmetical
//
//  Created by Pedro Sandoval on 8/26/16.
//  Copyright © 2016 Sandoval Software. All rights reserved.
//

import UIKit

class GameEndViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var newHighscoreLabel: UILabel!
    @IBOutlet weak var correctResponsesLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //Data Fields
    var studyQuestions: [[String]]?
    var correctResponses: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.correctResponsesLabel.text = String(correctResponses!)
        checkScore()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkScore() {
        //Check if this is a new highscore
        self.newHighscoreLabel.hidden = true
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.studyQuestions?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("previousQuestionCell") as! PreviousQuestionTableViewCell
        let question = self.studyQuestions![indexPath.row]
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
