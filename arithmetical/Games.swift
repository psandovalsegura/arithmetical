//
//  Games.swift
//  arithmetical
//
//  Created by Pedro Sandoval Segura on 8/4/16.
//  Copyright © 2016 Sandoval Software. All rights reserved.
//

import Foundation
import UIKit

class Games {
    //The Container class for the possible games that can be played
    
    
    //Add single digit numbers
    static let singleDigitAddition: Game = Game(gameArray: ["Single Digit Addition", "Add numbers. Easy as 1 + 1.", UIImage(named: "plus")!])
    
    //Add two digit numbers
    static let twoDigitAddition: Game = Game(gameArray: ["Double Digit Addition", "Add numbers. 23 + 15, get there.", UIImage(named: "plus")!])
    
    
    //Subtract from two digit numbers
    static let twoDigitSubtraction: Game = Game(gameArray: ["Two Digit Subtraction", "Subtract from two digit numbers. 10 - 2, try it.", UIImage(named: "minus")!])

    
    //Multiply single digit numbers
    static let singleDigitMultiplication: Game = Game(gameArray: ["Single Digit Multiplication", "Multiply numbers in a timed situation. 3 x 5, better be fast.", UIImage(named: "cross")!])

    
    static let allGames: [Game] = [Games.singleDigitAddition, Games.twoDigitAddition, Games.twoDigitSubtraction, Games.singleDigitMultiplication]

}