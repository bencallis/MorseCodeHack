//
//  HomeInterfaceController.swift
//  MorseCodeHack
//
//  Created by Ben Callis on 10/09/2015.
//  Copyright © 2015 iOSDevUK. All rights reserved.
//

import WatchKit
import Foundation


class HomeInterfaceController: WKInterfaceController {

    @IBOutlet var topScoreLabel: WKInterfaceLabel!
    
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

    func configureTopScoreLabel() {
        // TODO: get the current heigh score from the game? Or store is a property here?
        self.topScoreLabel.setText("Welcome :)")
    }

}
