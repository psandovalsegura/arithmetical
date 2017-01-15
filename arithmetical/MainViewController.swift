//
//  MainViewController.swift
//  arithmetical
//
//  Created by Pedro Sandoval Segura on 8/4/16.
//  Copyright © 2016 Sandoval Software. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var playButtonView: UIView!
    @IBOutlet weak var myStatsButtonView: UIView!
    @IBOutlet weak var settingsButtonView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        roundViewEdges(view: playButtonView)
        roundViewEdges(view: myStatsButtonView)
        roundViewEdges(view: settingsButtonView)
        
        //Main gradient
        let gradient = CAGradientLayer()
        gradient.frame = self.view.bounds
        gradient.colors = [UIColor(red: 51.0/255.0, green: 153.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor, UIColor.white.cgColor] //UIColor(red: 0.0/255.0, green: 186.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        gradient.startPoint = CGPoint(x: 0.5, y: 0.1)
        self.view.layer.insertSublayer(gradient, at: 0)
        
    }
    
    func roundViewEdges(view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowRadius = 0.02
        view.layer.cornerRadius = 50
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
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
