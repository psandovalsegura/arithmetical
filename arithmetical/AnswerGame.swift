//
//  AnswerGame.swift
//  arithmetical
//
//  Created by Pedro Sandoval on 8/26/16.
//  Copyright © 2016 Sandoval Software. All rights reserved.
//

import Foundation
import UIKit

class AnswerGame: Game {
    
    var questionGenerator: ( () -> (String) )!
    
    
    /* Instantiate a AnswerGame object looks like the following:
     *     Ex.
     */
    init(name: String, summary: String, image: UIImage, questionGenerator: @escaping () -> (String)) {
        super.init(name: name, summary: summary, image: image)
        self.questionGenerator = questionGenerator
    }
}
