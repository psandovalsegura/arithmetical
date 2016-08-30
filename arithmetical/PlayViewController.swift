//
//  PlayViewController.swift
//  arithmetical
//
//  Created by Pedro Sandoval Segura on 8/4/16.
//  Copyright © 2016 Sandoval Software. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let games = Games.allGames
    var chosenGame: Game?
    var selectedIndexPath: NSIndexPath?
    var option: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Games"
        
        //Setup table view
        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectedTimedGame(sender: AnyObject) {
        //Figure out which cell was tapped
        let buttonPosition: CGPoint = sender.convertPoint(CGPointZero, toView: self.tableView)
        let indexPath = self.tableView.indexPathForRowAtPoint(buttonPosition)
        let selectedGame = self.games[indexPath!.row]
        
        //Check what type of game was selected
        if let arithmeticGame = selectedGame as? ArithmeticGame {
            self.chosenGame = arithmeticGame
            self.option = "timed"
            self.performSegueWithIdentifier("toArithmeticGame", sender: nil)
        } else if let answerGame = selectedGame as? AnswerGame {
            self.chosenGame = answerGame
            self.option = "timed"
            self.performSegueWithIdentifier("toAnswerGame", sender: nil)
        }
    }
    
    @IBAction func selectedUnlimitedGame(sender: AnyObject) {
        //Figure out which cell was tapped
        let buttonPosition: CGPoint = sender.convertPoint(CGPointZero, toView: self.tableView)
        let indexPath = self.tableView.indexPathForRowAtPoint(buttonPosition)
        let selectedGame = self.games[indexPath!.row]
        
        //Check what type of game was selected
        if let arithmeticGame = selectedGame as? ArithmeticGame {
            self.chosenGame = arithmeticGame
            self.option = "unlimited"
            self.performSegueWithIdentifier("toArithmeticGame", sender: nil)
        } else if let answerGame = selectedGame as? AnswerGame {
            self.chosenGame = answerGame
            self.option = "unlimited"
            self.performSegueWithIdentifier("toAnswerGame", sender: nil)
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.games.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("gameCell") as! GameTableViewCell
        
        let game = self.games[indexPath.row]
        cell.gameLabel.text = game.name!
        cell.descriptionLabel.text = game.summary!
        cell.gameImageView?.image = game.image!
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //Update the selected indexPath to shrink or expand the size of the game cell
        switch selectedIndexPath {
        case nil:
            //If no cell has been selected before, save the indexPath
            selectedIndexPath = indexPath
        default:
            if selectedIndexPath == indexPath {
                //If the same row was selected, remove the saved indexPath
                selectedIndexPath = nil
            } else {
                //If a new cell is tapped, save this new indexPath
                selectedIndexPath = indexPath
            }
        }
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if self.selectedIndexPath == indexPath {
            return 128
        } else {
            return 98
        }
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //Segue to the corresponding game view controller
        if segue.identifier == "toArithmeticGame" {
            let arithmeticVC = segue.destinationViewController as! ArithmeticGamePlayViewController
            arithmeticVC.game = self.chosenGame as! ArithmeticGame
            arithmeticVC.option = self.option
        } else if segue.identifier == "toAnswerGame" {
            let answerVC = segue.destinationViewController as! AnswerGamePlayViewController
            answerVC.game = self.chosenGame as! AnswerGame
            answerVC.option = self.option
        }
    }
    

}
