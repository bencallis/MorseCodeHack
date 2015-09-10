//
//  GameEngine.swift
//  MorseCodeEngine
//
//  Created by Weingarten, Benny on 9/10/15.
//  Copyright © 2015 MorseTeam. All rights reserved.
//

import Foundation

let alphaNumToMorse = [
  "a": [.Dot,.Dash],
  "b": [.Dash,.Dot,.Dot,.Dot],
  "c": [.Dash,.Dot,.Dash,.Dot],
  "d": [.Dash,.Dot,.Dot],
  "e": [.Dot],
  "f": [.Dot,.Dot,.Dash,.Dot],
  "g": [.Dash,.Dash,.Dot],
  "h": [.Dot,.Dot,.Dot,.Dot],
  "i": [.Dot,.Dot],
  "j": [.Dot,.Dash,.Dash,.Dash],
  "k": [.Dash,.Dot,.Dash],
  "l": [.Dot,.Dash,.Dot,.Dot],
  "m": [.Dash,.Dash],
  "n": [.Dash,.Dot],
  "o": [.Dash,.Dash,.Dash],
  "p": [.Dot,.Dash,.Dash,.Dot],
  "q": [.Dash,.Dash,.Dot,.Dash],
  "r": [.Dot,.Dash,.Dot],
  "s": [.Dot,.Dot,.Dot],
  "t": [.Dash],
  "u": [.Dot,.Dot,.Dash],
  "v": [.Dot,.Dot,.Dot,.Dash],
  "w": [.Dot,.Dash,.Dash],
  "x": [.Dash,.Dot,.Dot,.Dash],
  "y": [.Dash,.Dot,.Dash,.Dash],
  "z": [.Dash,.Dash,.Dot,.Dot],
  "1": [.Dot,.Dash,.Dash,.Dash,.Dash],
  "2": [.Dot,.Dot,.Dash,.Dash,.Dash],
  "3": [.Dot,.Dot,.Dot,.Dash,.Dash],
  "4": [.Dot,.Dot,.Dot,.Dot,.Dash],
  "5": [.Dot,.Dot,.Dot,.Dot,.Dot],
  "6": [.Dash,.Dot,.Dot,.Dot,.Dot],
  "7": [.Dash,.Dash,.Dot,.Dot,.Dot],
  "8": [.Dash,.Dash,.Dash,.Dot,.Dot],
  "9": [.Dash,.Dash,.Dash,.Dash,.Dot],
  "0": [.Dash,.Dash,.Dash,.Dash,.Dash],
]

enum MorseCharacter {
  case Dot
  case Dash
  case Space
}

struct Round {
  var letter: String
  var morseCode: [MorseCharacter]
  var alternatives: [String]
}

func getNextRound() -> Round {
  var indices = (0...alphaNumToMorse.count).map { $0 }
  let keys: [String] = [String](alphaNumToMorse.keys)

  var letters: [String] = []
  for _ in 0...3 {
    let random = arc4random_uniform(UInt32(indices.count))
    let letter = keys[Int(random)]
    letters.append(letter)
    indices.removeAtIndex(Int(random))
  }

  let designatedLetter = letters[0]
  let thisRound = Round(letter: designatedLetter, morseCode: alphaNumToMorse[designatedLetter]!, alternatives:Array(letters[1..<letters.count]))
  return thisRound
}

