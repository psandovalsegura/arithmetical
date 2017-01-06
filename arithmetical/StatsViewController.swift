//
//  StatsViewController.swift
//  arithmetical
//
//  Created by Pedro Sandoval Segura on 8/4/16.
//  Copyright © 2016 Sandoval Software. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Top Scores"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //Change navigation bar colors depending on view controller
        /*
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.barTintColor = UIColor(red: 0.0/255.0, green: 186.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        navigationBar?.tintColor = UIColor.white
        navigationBar?.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        */
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Games.allGames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "topScoresCell") as! TopScoresTableViewCell
      
        let currentGame = Games.allGames[indexPath.row]
        
        cell.gameImageView.image = currentGame.image!
        cell.gameLabel.text = currentGame.name!
        
        if let highscoreArray = UserDefaults.standard.stringArray(forKey: "\(currentGame.name!)_highscore") {
            cell.highscoreLabel.text = highscoreArray[0]
            cell.playerLabel.text = highscoreArray[1]
            cell.topScoreCheckmarkImageView.isHidden = false
        } else {
            cell.highscoreLabel.text = "-"
        }
        
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
