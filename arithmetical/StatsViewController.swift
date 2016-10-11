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
        self.title = "My Stats"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Games.allGames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "topScoresCell") as! TopScoresTableViewCell
      
        let currentGame = Games.allGames[indexPath.row]
        
        cell.gameImageView.image = currentGame.image!
        cell.gameLabel.text = currentGame.name!
        cell.highScore.text = String(UserDefaults.standard.integer(forKey: "\(currentGame.name)_highscore"))
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
