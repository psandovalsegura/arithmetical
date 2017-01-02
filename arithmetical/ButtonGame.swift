//
//  ButtonGame.swift
//  arithmetical
//
//  Created by Pedro Sandoval on 12/28/16.
//  Copyright © 2016 Sandoval Software. All rights reserved.
//

import Foundation
import UIKit

class ButtonGame: Game {
    
    var selectionDictionary: [String: Int]!
    var mainPromptGenerator: ( () -> (String) )!
    
    /* Instantiate a ButtonGame object looks like the following:
     *     Ex. ButtonGame(name: "The Unit Circle", image: UIImage(named: "circle"), .. )
     */
    init(name: String, summary: String, instructions: String, image: UIImage, selectionImage: UIImage, selectionDictionary: [String: Int]) {
        super.init(name: name, summary: summary, instructions: instructions, image: image, selectionImage: selectionImage)
        
        self.selectionDictionary = selectionDictionary
        var keys = [String] (selectionDictionary.keys)
        self.mainPromptGenerator = { () in
            let chosenIndex = Int(arc4random_uniform(UInt32(keys.count)))
            return keys[chosenIndex]
        }
    }
    
}
