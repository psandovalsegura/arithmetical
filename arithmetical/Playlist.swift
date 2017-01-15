//
//  Playlist.swift
//  arithmetical
//
//  Created by Pedro Sandoval on 1/13/17.
//  Copyright © 2017 Sandoval Software. All rights reserved.
//

import Foundation

class Playlist: NSObject {
    
    //Fields
    var id: String?
    var name: String?
    var uri: String?
    var tracks:[Track] = []
    
    var owner: String?
    
    init(dictionary: NSDictionary) {
        super.init()
        self.id = dictionary["id"] as? String
        self.name = dictionary["name"] as? String
        self.uri = dictionary["uri"] as? String
        
        let ownerDictionary = dictionary["owner"] as! NSDictionary
        self.owner = ownerDictionary["id"] as? String
        
        
    }
}
