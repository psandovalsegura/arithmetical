//
//  ArithmeticGame.swift
//  arithmetical
//
//  Created by Pedro Sandoval Segura on 8/4/16.
//  Copyright © 2016 Sandoval Software. All rights reserved.
//

import Foundation
import UIKit

class ArithmeticGame: Game {
    
    var number1generation: ( () -> (Int) )!
    var number2generation: ( () -> (Int) )!
    var operation: ( (Int, Int) -> (Int) )!
    
    
    /* Instantiate a ArithmeticGame object looks like the following:
     *     Ex.
     */
    init(name: String, summary: String, image: UIImage, number1generation: @escaping () -> (Int), number2generation: @escaping () -> (Int), operation: @escaping (Int, Int) -> (Int)) {

        super.init(name: name, summary: summary, image: image)
        
        self.number1generation = number1generation
        self.number2generation = number2generation
        self.operation = operation
    }
}
