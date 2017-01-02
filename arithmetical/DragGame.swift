//
//  DragGame.swift
//  arithmetical
//
//  Created by Pedro Sandoval on 11/4/16.
//  Copyright © 2016 Sandoval Software. All rights reserved.
//

import Foundation
import UIKit

class DragGame: Game {
    
    var mainNumberGenerator: ( () -> (Int) )!
    
    /* Instantiate a DragGame object looks like the following:
     *     Ex.
     */
    init(name: String, summary: String, instructions: String, image: UIImage, selectionImage: UIImage, numberGenerator: @escaping () -> (Int)) {
        super.init(name: name, summary: summary, instructions: instructions, image: image, selectionImage: selectionImage)
        self.mainNumberGenerator = numberGenerator
    }
}
