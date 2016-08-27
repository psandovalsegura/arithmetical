//
//  Game.swift
//  arithmetical
//
//  Created by Pedro Sandoval Segura on 8/4/16.
//  Copyright © 2016 Sandoval Software. All rights reserved.
//

import Foundation
import UIKit

class ArithmeticGame: NSObject {
    
    let name: String?
    let summary: String?
    let image: UIImage?
    let number1generation: ( () -> (Int) )!
    let number2generation: ( () -> (Int) )!
    let operation: ( (Int, Int) -> (Int) )!
    //let options: [String]? //Should this field move forward?
    
    
    /* The gamesArray necessary to instantiate a Game object looks like the following:
     *     Ex.  [name: String, summary: String, image: UIImage, options: [String]]
     */
    init(name: String, summary: String, image: UIImage, number1generation: () -> (Int), number2generation: () -> (Int), operation: (Int, Int) -> (Int)) {
        self.name = name
        self.summary = summary
        self.image = image
        self.number1generation = number1generation
        self.number2generation = number2generation
        self.operation = operation
    }
}