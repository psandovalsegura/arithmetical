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
    static let singleDigitAddition: ArithmeticGame = ArithmeticGame(name: "Single Digit Addition", summary: "Add numbers. Easy as 1 + 1.", image: UIImage(named: "plus")!, number1generation: { () in return Int(arc4random_uniform(9) + 1)}, number2generation: { () in return Int(arc4random_uniform(9) + 1)}, operation: +)
    
    //Add two digit numbers
    static let twoDigitAddition: ArithmeticGame = ArithmeticGame(name: "Two Digit Addition", summary: "Add numbers. 23 + 15, get there.", image: UIImage(named: "plus")!, number1generation: { () in return Int(arc4random_uniform(90) + 10)}, number2generation: { () in return Int(arc4random_uniform(90) + 10)}, operation: +)
    
    
    //Subtract from two digit numbers
    static let twoDigitSubtraction: ArithmeticGame = ArithmeticGame(name: "Two Digit Subtraction", summary: "Subtract from two digit numbers. 10 - 2, try it.", image: UIImage(named: "minus")!, number1generation: { () in return Int(arc4random_uniform(40) + 60)}, number2generation: { () in return Int(arc4random_uniform(59) + 1)}, operation: -)

    
    //Multiply single digit numbers
    static let singleDigitMultiplication: ArithmeticGame = ArithmeticGame(name: "Single Digit Multiplication", summary: "Multiply numbers in a timed situation. 3 x 5, better be fast.", image: UIImage(named: "cross")!, number1generation: { () in return Int(arc4random_uniform(8) + 2)}, number2generation: { () in return Int(arc4random_uniform(8) + 2)}, operation: *)

    //Compute binary -> Chooses a number between 1 and 63 to include six binary digits
    static let binaryToDecimal: AnswerGame = AnswerGame(name: "Binary to Decimal", summary: "Speak computer. Go from 1101 to 13", image: UIImage(named: "plus")!, questionGenerator: {() in return String(Int(arc4random_uniform(63) + 1), radix: 2)})
    
    
    static let allGames: [Game] = [Games.singleDigitAddition, Games.twoDigitAddition, Games.twoDigitSubtraction, Games.singleDigitMultiplication, Games.binaryToDecimal]
    

    // Mark -- Extra functionality
    static func stringFromTimeInterval(_ seconds: Int) -> NSString {
        let minutes = seconds / 60
        let seconds = seconds % 60
        
        return NSString(format: "%0.2d:%0.2d",minutes,seconds)
    }
}
