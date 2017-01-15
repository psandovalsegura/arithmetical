//
//  Album.swift
//  arithmetical
//
//  Created by Pedro Sandoval on 1/13/17.
//  Copyright © 2017 Sandoval Software. All rights reserved.
//

import Foundation

class Album: NSObject {
    
    //Fields
    var id: String?
    var albumImageUrl: String?
    var name: String?
    var uri: String?
    
    
    init(dictionary: NSDictionary) {
        self.id = dictionary["id"] as? String
        
        let albumImageDictionary = dictionary["images"] as? [NSDictionary]
        self.albumImageUrl = albumImageDictionary![0]["url"] as? String
        
        self.name = dictionary["name"] as? String
        self.uri = dictionary["uri"] as? String
        
    }
    
    
    
}
