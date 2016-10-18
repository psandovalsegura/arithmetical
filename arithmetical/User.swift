//
//  User.swift
//  arithmetical
//
//  Created by Pedro Sandoval on 10/18/16.
//  Copyright © 2016 Sandoval Software. All rights reserved.
//

import Foundation

class User {
    // A class to keep track of user specific variables and functions necessary throughout the application
    
    /*
     A function that returns the previously entered player name or an empty string if no player name has been entered before.
     */
    static func getName() -> String {
        //Retrieve name from User Defaults if one exists
        if let name = UserDefaults.standard.string(forKey: "user") {
            return name
        }
        
        return ""
    }
    
    static func saveName(name: String) {
        UserDefaults.standard.set(name, forKey: "user")
    }
}
