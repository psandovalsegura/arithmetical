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
    static let timerSeconds = 20
    
    //TODO: Update the spotifyActivated variable to accurately reflect whether the access token remains valid
    static var spotifyActivated = false
    
    //Add single digit numbers
    static let singleDigitAddition: ArithmeticGame = ArithmeticGame(name: "Single Digit Addition", summary: "Add numbers. Easy as 1 + 1.", instructions: "Type your answer to random addition problems into the text field. You can tap outside the text field to view previosly answered questions!", image: UIImage(named: "plus")!, selectionImage: UIImage(named: "plusWhite")!, number1generation: { () in return Int(arc4random_uniform(9) + 1)}, number2generation: { () in return Int(arc4random_uniform(9) + 1)}, operation: +)
    
    //Add two digit numbers
    static let twoDigitAddition: ArithmeticGame = ArithmeticGame(name: "Two Digit Addition", summary: "Add numbers. 23 + 15, get there.", instructions: "Type your answer to random addition problems into the text field. You can tap outside the text field to view previosly answered questions!", image: UIImage(named: "plus")!, selectionImage: UIImage(named: "plusWhite")!, number1generation: { () in return Int(arc4random_uniform(90) + 10)}, number2generation: { () in return Int(arc4random_uniform(90) + 10)}, operation: +)
    
    
    //Subtract from two digit numbers
    static let twoDigitSubtraction: ArithmeticGame = ArithmeticGame(name: "Two Digit Subtraction", summary: "Subtract from two digit numbers. 10 - 2, try it.", instructions: "Type your answer to random subtraction problems into the text field. You can tap outside the text field to view previosly answered questions!", image: UIImage(named: "minus")!, selectionImage: UIImage(named: "minusWhite")!, number1generation: { () in return Int(arc4random_uniform(40) + 60)}, number2generation: { () in return Int(arc4random_uniform(59) + 1)}, operation: -)

    
    //Multiply single digit numbers
    static let singleDigitMultiplication: ArithmeticGame = ArithmeticGame(name: "Single Digit Multiplication", summary: "Multiply numbers in a timed situation. 3 x 5, better be fast.", instructions: "Type your answer to random multiplication problems into the text field. You can tap outside the text field to view previosly answered questions!", image: UIImage(named: "cross")!, selectionImage: UIImage(named: "crossWhite")!, number1generation: { () in return Int(arc4random_uniform(8) + 2)}, number2generation: { () in return Int(arc4random_uniform(8) + 2)}, operation: *)

    //Compute binary to decimal
    //The question generator chooses a number between 1 and 63 to include up to six binary digits
    static let binaryToDecimal: AnswerGame = AnswerGame(name: "Binary to Decimal", summary: "Speak computer. Go from 1101 to 13.", instructions: "Convert base 2 numbers to base 10 and type your answer into the text field. You can tap outside the text field to view previosly answered questions!", image: UIImage(named: "plus")!, selectionImage: UIImage(named: "plusWhite")!,questionGenerator: {() in return String(Int(arc4random_uniform(63) + 1), radix: 2)})
    
    //Prime factorization
    static let primeFactorization: DragGame = DragGame(name: "Prime Factorization", summary: "Factor numbers into primes by dragging factors into the main number.", instructions: "Touch and drag primes that divide into the main number. Remembering divisibility rules will be helpful here!", image: UIImage(named: "star")!, selectionImage: UIImage(named: "starWhite")!, numberGenerator: {() in
        let numberOfFactors = Int(arc4random_uniform(4) + 2) // generated number should have 2 to 5 factors
        let tray = [2,3,5,7,11]
        var factors: [Int] = []
        for _ in 1...numberOfFactors {
            let chosenIndex = Int(arc4random_uniform(UInt32(tray.count)))
            factors.append(tray[chosenIndex])
        }
        //Create a product of the chosen factors
        return factors.reduce(1, *)})
    
    //Unit circle: radians
    static let unitCircleRadians = ButtonGame(name: "Unit Circle: Radians", summary: "Memorize where each radian value lies on the unit circle!", instructions: "Given a radian value, tap on the corresponding angle of the unit circle. The endpoints of the main radii, at different angles, are a darker shade of blue.", image: UIImage(named: "circle")!, selectionImage: UIImage(named: "circleWhite")!, selectionDictionary: ["2π": 0, "π/6": 1, "π/4": 2, "π/3": 3 , "π/2": 4, "2π/3": 5, "3π/4": 6, "5π/6": 7, "π": 8, "7π/6": 9, "5π/4": 10, "4π/3": 11, "3π/2": 12, "5π/3": 13, "7π/4": 14, "11π/6": 15])
    
    static let allGames: [Game] = [Games.singleDigitAddition, Games.twoDigitAddition, Games.twoDigitSubtraction, Games.singleDigitMultiplication, Games.binaryToDecimal, Games.primeFactorization, Games.unitCircleRadians]
}
