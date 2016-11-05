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
    
    /* Instantiate a AnswerGame object looks like the following:
     *     Ex.
     */
    init(name: String, summary: String, image: UIImage, numberGenerator: @escaping () -> (Int)) {
        super.init(name: name, summary: summary, image: image)
        self.mainNumberGenerator = numberGenerator
    }
}
