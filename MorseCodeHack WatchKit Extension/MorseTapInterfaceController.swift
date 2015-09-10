//
//  MorseTapInterfaceController.swift
//  taptest
//
//  Created by Paul Beattie on 10/09/2015.
//  Copyright © 2015 Mauley Media Ltd. All rights reserved.
//

import WatchKit
import Foundation



public class MorseTapInterfaceController {


    // The button actions
    public func NotificationTap() {
        WKInterfaceDevice().playHaptic(.Notification)
    }

    public func DirectionUpTap() {
        WKInterfaceDevice().playHaptic(.DirectionUp)
    }

    public func DirectionDownTap() {
        WKInterfaceDevice().playHaptic(.DirectionDown)
    }

    public func SuccessTap() {
        WKInterfaceDevice().playHaptic(.Success)
    }

    static func FailureTap() {
        WKInterfaceDevice().playHaptic(.Failure)
    }

    public func RetryTap() {
        WKInterfaceDevice().playHaptic(.Retry)
    }

    static func StartTap() {
        WKInterfaceDevice().playHaptic(.Start)
    }

    public func StopTap() {
        WKInterfaceDevice().playHaptic(.Stop)
    }

    public func ClickTap() {
        WKInterfaceDevice().playHaptic(.Click)
    }


    static func dot(){
        StartTap()
    }

    static func dash(){
        FailureTap()
    }

    public func foo(){
        print("hi")
    }

    public static func processCode(code : [MorseCharacter]){
        if !code.isEmpty {
            for char in code {
                switch (char) {
                case .Dot:
                    dot()
                case .Dash:
                    dash()
                case .Space:
                    print("space")
                }
                NSThread.sleepForTimeInterval(0.7)
                
            }
        }
    }

}
