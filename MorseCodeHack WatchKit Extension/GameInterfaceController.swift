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
    
    @IBOutlet var bottomRight: WKInterfaceButton!
    @IBOutlet var bottomLeft: WKInterfaceButton!
    @IBOutlet var topright: WKInterfaceButton!
    @IBOutlet var topLeft: WKInterfaceButton!
  
    var score : Int = 0 {
        didSet {
            self.setTitle("Score \(score)")
        }
    }
  
    var buttonsArray: [WKInterfaceButton]!
    var correctButton: WKInterfaceButton!
    var currentRound : Round!
      
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
      buttonsArray = [topLeft, topright, bottomLeft, bottomRight]
        reloadRound()
        score = 0
    }

    func reloadRound() {
        let newRound = getNextRound()
        currentRound = newRound
        
        let numberOfOptions = newRound.alternatives.count + 1
        
        var arrayOfChoices = newRound.alternatives + [newRound.letter]
        for index in 0..<arrayOfChoices.count {
            let swapIndex = Int(arc4random_uniform(UInt32(numberOfOptions)))
            let temp = arrayOfChoices[index]
            arrayOfChoices[index] = arrayOfChoices[swapIndex]
            arrayOfChoices[swapIndex] = temp
        }
      
      let correctIndex = arrayOfChoices.indexOf(newRound.letter)
      correctButton = buttonsArray[correctIndex!]
      for index in 0..<buttonsArray.count {
        buttonsArray[index].setTitle(arrayOfChoices[index])
        buttonsArray[index].setBackgroundColor(UIColor(red: 178/255, green: 115/255, blue: 237/255, alpha: 1))
      }

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
          MorseTapInterfaceController.processCode(newRound.morseCode)
        }
    }

  
  @IBAction func topLeftTapped() {
    buttonTapped(topLeft)
  }
  @IBAction func topRightTapped() {
    buttonTapped(topright)
    
  }
  @IBAction func bottomLeftTapped() {
    buttonTapped(bottomLeft)

  }
  @IBAction func bottomRightapped() {
    buttonTapped(bottomRight)
  }
  
  func buttonTapped(sender: WKInterfaceButton) {
    correctButton.setBackgroundColor(UIColor.greenColor())
    if (sender == correctButton) {
      let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
      dispatch_after(delayTime, dispatch_get_main_queue(), {
        self.handleCorrectAnswer()
      })
    } else {
      sender.setBackgroundColor(UIColor.redColor())
      handleWrongAnswer()
    }
  }
  
    func handleCorrectAnswer () {
        score++
        reloadRound()
    }
    
    func handleWrongAnswer ()  {
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue(), {
            self.popToRootController()
        })
    }
}
