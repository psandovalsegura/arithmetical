//
//  User.swift
//  arithmetical
//
//  Created by Pedro Sandoval on 10/18/16.
//  Copyright © 2016 Sandoval Software. All rights reserved.
//

import Foundation

class User: NSObject {
    // A class to keep track of user specific variables and functions necessary throughout the application
    
    //Fields
    var birthdate: String?
    var email: String?
    var id: String?
    var uri: String?
    var profileImageUrl: String? //May be nil if user does not have a profile picture
    var fullName: String?
    
    
    init(dictionary: NSDictionary) {
        self.birthdate = dictionary["birthdate"] as? String //Should be an NSDate
        self.email = dictionary["email"] as? String
        self.id = dictionary["id"] as? String
        self.uri = dictionary["uri"] as? String
        self.fullName = dictionary["display_name"] as? String
        
        //Check if the user has a profile picture
        if let imageDictionary = dictionary["images"] as? [NSDictionary] {
            if !imageDictionary.isEmpty {
                self.profileImageUrl = imageDictionary[0]["url"] as? String
            } else {
                self.profileImageUrl = ""
            }
            
        } else {
            self.profileImageUrl = ""
        }
        
    }

    
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
