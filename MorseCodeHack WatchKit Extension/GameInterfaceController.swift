//
//  GameInterfaceController.swift
//  MorseCodeHack
//
//  Created by Ben Callis on 10/09/2015.
//  Copyright © 2015 iOSDevUK. All rights reserved.
//

import WatchKit
import Foundation


class GameInterfaceController: WKInterfaceController {
    
    var score : Int = 0{
        didSet {
            currentScoreLabel.setText(String(score))
        }
    }

    @IBOutlet var currentScoreLabel: WKInterfaceLabel!
    
    @IBOutlet var choicesTable: WKInterfaceTable!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        reloadRound()
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }


    func reloadRound() {
        let newRound = getNextRound()
        
        let numberOfOptions = newRound.alternatives.count + 1
        choicesTable.setNumberOfRows(numberOfOptions, withRowType: "choiceRow")

        var arrayOfChoices = newRound.alternatives + [newRound.letter]
        for index in 0..<arrayOfChoices.count {
            let swapIndex = Int(arc4random_uniform(UInt32(numberOfOptions)))
            let temp = arrayOfChoices[index]
            arrayOfChoices[index] = arrayOfChoices[swapIndex]
            arrayOfChoices[swapIndex] = temp
        }
        
        for index in 0..<4 {
            if let row = choicesTable.rowControllerAtIndex(index) as? SimpleRow {
                row.titleLabel.setText(arrayOfChoices[index])
            }
        }
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        if let row = table.rowControllerAtIndex(rowIndex) as? SimpleRow {
            let isCorrect = true
            let colour = isCorrect ? UIColor.redColor() : UIColor.greenColor()
            row.group.setBackgroundColor(colour)
            
            if isCorrect {
                handleCorrectAnswer()
            } else {
                handleWrongAnswer()
            }
        
        }
    }
    
    func handleCorrectAnswer () {
        score++
        // start new game
        reloadRound()
    }
    
    func handleWrongAnswer () {
        // throw back to main menu
    }

}
