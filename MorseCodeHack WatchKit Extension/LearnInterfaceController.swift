//
//  LearnInterfaceController.swift
//  MorseCodeHack
//
//  Created by Ben Callis on 10/09/2015.
//  Copyright © 2015 iOSDevUK. All rights reserved.
//

import WatchKit
import Foundation


class LearnInterfaceController: WKInterfaceController {

    @IBOutlet var learnTable: WKInterfaceTable!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        let numberOfLetters = alphaNumToMorse.count
        learnTable.setNumberOfRows(numberOfLetters, withRowType: "learnRow")
        let sortedKeysAndValues = alphaNumToMorse.sort { $0.0 < $1.0 }

        var counter = 0
        for (character, code) in sortedKeysAndValues {
            if let row = learnTable.rowControllerAtIndex(counter) as? LearnRow {
                let stringRep = code.reduce("") { (currentString, code) in currentString + code.rawValue }
                row.titleLabel.setText(character)
                row.morseCodeLabel.setText(stringRep)
                
                counter++
            }
        }
    }

    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        let sortedKeysAndValues = alphaNumToMorse.sort { $0.0 < $1.0 }
        let (_, code) = sortedKeysAndValues[rowIndex]
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            MorseTapInterfaceController.processCode(code)
        }
    }
}
