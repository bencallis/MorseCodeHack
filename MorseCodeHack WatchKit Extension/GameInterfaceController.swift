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

    @IBOutlet var currentScoreLabel: WKInterfaceLabel!
    
    @IBOutlet var choicesTable: WKInterfaceTable!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
//    func reloadCurrentGame {
//        // 1
//        choicesTable.setNumberOfRows(10, withRowType: "CoinRow")
//        
//        for (index, coin) in enumerate(coins) {
//            // 2
//            if let row = coinTable.rowControllerAtIndex(index) as? CoinRow {
//                // 3
//                row.titleLabel.setText(coin.name)
//                row.detailLabel.setText("\(coin.price)")
//            }
//        }
//    }

}
