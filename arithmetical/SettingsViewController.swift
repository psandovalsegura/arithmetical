//
//  SettingsViewController.swift
//  arithmetical
//
//  Created by Pedro Sandoval Segura on 8/4/16.
//  Copyright © 2016 Sandoval Software. All rights reserved.
//

import UIKit
import SafariServices

class SettingsViewController: UIViewController {
    
    var safariVC: SFSafariViewController?

    @IBOutlet weak var spotifySwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
    
        // Do any additional setup after loading the view.
        self.spotifySwitch.isOn = Games.spotifyActivated ? true: false
        
        NotificationCenter.default.addObserver(self, selector: #selector(loginSuccess), name: NSNotification.Name(rawValue: "closeSafariOnLogin"), object: nil)
    }
    
    //This function is here for Spotify Authentication testing
    /*
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let token = SPTAuth.defaultInstance().session {
            print("Access token is here.")
        }else {
            print("No access token yet")
        }
    }
    */

    @IBAction func onSpotifySwitch(_ sender: UISwitch) {
        if sender.isOn == false {
            Games.spotifyActivated = false
        } else {
            // TODO: Check if the access token is still valid to prevent Safari VC popup
            
            let requestedScopes = [SPTAuthStreamingScope, SPTAuthPlaylistReadPrivateScope, SPTAuthPlaylistModifyPrivateScope, SPTAuthUserLibraryReadScope, SPTAuthUserLibraryModifyScope, SPTAuthUserReadPrivateScope, SPTAuthUserReadTopScope, SPTAuthUserReadEmailScope]
            
            let loginUrl: NSURL = SPTAuth.loginURL(forClientId: SpotifyClient.CLIENT_ID, withRedirectURL: NSURL(string: SpotifyClient.CALLBACK_URL) as URL!, scopes: requestedScopes, responseType: "token") as NSURL
            
            //Open login with SafariViewController
            self.safariVC = SFSafariViewController(url: loginUrl as URL)
            self.present(self.safariVC!, animated: true, completion: nil)
        }
    }
    
    func loginSuccess() {
        self.safariVC?.dismiss(animated: true, completion: nil)
        SpotifyClient.loginToSpotifyPlayer()
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
