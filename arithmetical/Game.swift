//
//  Game.swift
//  arithmetical
//
//  Created by Pedro Sandoval on 8/26/16.
//  Copyright © 2016 Sandoval Software. All rights reserved.
//

import Foundation
import UIKit

class Game: NSObject {
    
    let name: String?
    let summary: String?
    let instructions: String?
    let image: UIImage?
    let selectionImage: UIImage?
    
    
    /* Instantiate a Game object looks like the following:
     *     Ex.
     */
    init(name: String, summary: String, instructions: String, image: UIImage, selectionImage: UIImage) {
        self.name = name
        self.summary = summary
        self.instructions = instructions
        self.image = image
        self.selectionImage = selectionImage
    }
    
    // Mark -- Extra functionality
    static func stringFromTimeInterval(_ seconds: Int) -> NSString {
        let minutes = seconds / 60
        let seconds = seconds % 60
        
        return NSString(format: "%0.2d:%0.2d", minutes, seconds)
    }
}
