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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Games"
        
        //Setup table view
        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
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
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        if let optionsVC = segue.destinationViewController as? InGameViewController {
            let cellTapped = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cellTapped)
            
            optionsVC.game = self.games[(indexPath?.row)!]
        }
        
    }
    

}
