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
    
    var mainPromptGenerator: ( () -> (String) )!
    
    /* Instantiate a DragGame object looks like the following:
     *     Ex.
     */
    init(name: String, summary: String, image: UIImage, mainPromptGenerator: @escaping () -> (String)) {
        super.init(name: name, summary: summary, image: image)
        self.mainPromptGenerator = mainPromptGenerator
    }
    
}
