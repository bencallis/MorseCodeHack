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
    
    var score : Int = 0 {
        didSet {
            currentScoreLabel.setText(String(score))
        }
    }
    var currentRound : Round!

    @IBOutlet var currentScoreLabel: WKInterfaceLabel!
    @IBOutlet var currentScoreTitleLabel: WKInterfaceLabel!
    
    @IBOutlet var choicesTable: WKInterfaceTable!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        reloadRound()
        score = 0
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }


    func reloadRound() {
        let newRound = getNextRound()
        currentRound = newRound
        
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
                let text = arrayOfChoices[index]
                row.titleLabel.setText(text)
                row.titleText = text
            }
        }

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
          MorseTapInterfaceController.processCode(newRound.morseCode)
        }
    }

    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        if let row = table.rowControllerAtIndex(rowIndex) as? SimpleRow {
            let isCorrect = row.titleText == currentRound.letter
            let colour = isCorrect ? UIColor.greenColor() : UIColor.redColor()
            row.group.setBackgroundColor(colour)
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.25 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue(), { () -> Void in
                if isCorrect {
                    self.handleCorrectAnswer()
                } else {
                    self.handleWrongAnswer()
                }
            })
        }
    }
    
    func handleCorrectAnswer () {
        score++
        reloadRound()
    }
    
    func handleWrongAnswer () {
        currentScoreLabel.setHidden(true)
        currentScoreTitleLabel.setText("Game Over")
        for index in 0..<4 {
            if let row = choicesTable.rowControllerAtIndex(index) as? SimpleRow {
                let isCorrect = row.titleText == currentRound.letter
                let colour = isCorrect ? UIColor.greenColor() : UIColor.redColor()
                row.group.setBackgroundColor(colour)
            }
        }
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue(), { () -> Void in
            self.popToRootController()
        })
    }
}
