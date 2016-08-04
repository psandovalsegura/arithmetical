//
//  Game.swift
//  arithmetical
//
//  Created by Pedro Sandoval Segura on 8/4/16.
//  Copyright © 2016 Sandoval Software. All rights reserved.
//

import Foundation
import UIKit

class Game: NSObject {
    
    let name: String?
    let summary: String?
    let image: UIImage?
    //let options: [String]? //Should this field move forward?
    
    
    /* The gamesArray necessary to instantiate a Game object looks like the following:
     *     Ex.  [name: String, summary: String, image: UIImage, options: [String]]
     */
    init(gameArray: [AnyObject]) {
        self.name = gameArray[0] as? String
        self.summary = gameArray[1] as? String
        self.image = gameArray[2] as? UIImage
    }
}