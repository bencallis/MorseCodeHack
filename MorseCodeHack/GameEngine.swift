//
//  GameEngine.swift
//  MorseCodeEngine
//
//  Created by Weingarten, Benny on 9/10/15.
//  Copyright © 2015 MorseTeam. All rights reserved.
//

import Foundation

let alphaNumToMorse = [
  "a": [MorseCharacter.Dot,MorseCharacter.Dash],
  "b": [MorseCharacter.Dash,MorseCharacter.Dot,MorseCharacter.Dot,MorseCharacter.Dot],
  "c": [MorseCharacter.Dash,MorseCharacter.Dot,MorseCharacter.Dash,MorseCharacter.Dot],
  "d": [MorseCharacter.Dash,MorseCharacter.Dot,MorseCharacter.Dot],
  "e": [MorseCharacter.Dot],
  "f": [MorseCharacter.Dot,MorseCharacter.Dot,MorseCharacter.Dash,MorseCharacter.Dot],
  "g": [MorseCharacter.Dash,MorseCharacter.Dash,MorseCharacter.Dot],
  "h": [MorseCharacter.Dot,MorseCharacter.Dot,MorseCharacter.Dot,MorseCharacter.Dot],
  "i": [MorseCharacter.Dot,MorseCharacter.Dot],
  "j": [MorseCharacter.Dot,MorseCharacter.Dash,MorseCharacter.Dash,MorseCharacter.Dash],
  "k": [MorseCharacter.Dash,MorseCharacter.Dot,MorseCharacter.Dash],
  "l": [MorseCharacter.Dot,MorseCharacter.Dash,MorseCharacter.Dot,MorseCharacter.Dot],
  "m": [MorseCharacter.Dash,MorseCharacter.Dash],
  "n": [MorseCharacter.Dash,MorseCharacter.Dot],
  "o": [MorseCharacter.Dash,MorseCharacter.Dash,MorseCharacter.Dash],
  "p": [MorseCharacter.Dot,MorseCharacter.Dash,MorseCharacter.Dash,MorseCharacter.Dot],
  "q": [MorseCharacter.Dash,MorseCharacter.Dash,MorseCharacter.Dot,MorseCharacter.Dash],
  "r": [MorseCharacter.Dot,MorseCharacter.Dash,MorseCharacter.Dot],
  "s": [MorseCharacter.Dot,MorseCharacter.Dot,MorseCharacter.Dot],
  "t": [MorseCharacter.Dash],
  "u": [MorseCharacter.Dot,MorseCharacter.Dot,MorseCharacter.Dash],
  "v": [MorseCharacter.Dot,MorseCharacter.Dot,MorseCharacter.Dot,MorseCharacter.Dash],
  "w": [MorseCharacter.Dot,MorseCharacter.Dash,MorseCharacter.Dash],
  "x": [MorseCharacter.Dash,MorseCharacter.Dot,MorseCharacter.Dot,MorseCharacter.Dash],
  "y": [MorseCharacter.Dash,MorseCharacter.Dot,MorseCharacter.Dash,MorseCharacter.Dash],
  "z": [MorseCharacter.Dash,MorseCharacter.Dash,MorseCharacter.Dot,MorseCharacter.Dot],
  "1": [MorseCharacter.Dot,MorseCharacter.Dash,MorseCharacter.Dash,MorseCharacter.Dash,MorseCharacter.Dash],
  "2": [MorseCharacter.Dot,MorseCharacter.Dot,MorseCharacter.Dash,MorseCharacter.Dash,MorseCharacter.Dash],
  "3": [MorseCharacter.Dot,MorseCharacter.Dot,MorseCharacter.Dot,MorseCharacter.Dash,MorseCharacter.Dash],
  "4": [MorseCharacter.Dot,MorseCharacter.Dot,MorseCharacter.Dot,MorseCharacter.Dot,MorseCharacter.Dash],
  "5": [MorseCharacter.Dot,MorseCharacter.Dot,MorseCharacter.Dot,MorseCharacter.Dot,MorseCharacter.Dot],
  "6": [MorseCharacter.Dash,MorseCharacter.Dot,MorseCharacter.Dot,MorseCharacter.Dot,MorseCharacter.Dot],
  "7": [MorseCharacter.Dash,MorseCharacter.Dash,MorseCharacter.Dot,MorseCharacter.Dot,MorseCharacter.Dot],
  "8": [MorseCharacter.Dash,MorseCharacter.Dash,MorseCharacter.Dash,MorseCharacter.Dot,MorseCharacter.Dot],
  "9": [MorseCharacter.Dash,MorseCharacter.Dash,MorseCharacter.Dash,MorseCharacter.Dash,MorseCharacter.Dot],
  "0": [MorseCharacter.Dash,MorseCharacter.Dash,MorseCharacter.Dash,MorseCharacter.Dash,MorseCharacter.Dash],
]

enum MorseCharacter : String {
  case Dot = "."
  case Dash = "-"
  case Space = " "
}

struct Round {
  var letter: String
  var morseCode: [MorseCharacter]
  var alternatives: [String]
}

func getNextRound() -> Round {
  var indices = (0...alphaNumToMorse.count - 1).map { $0 }
  let keys: [String] = [String](alphaNumToMorse.keys)

  var letters: [String] = []
  for _ in 0...3 {
    let random = arc4random_uniform(UInt32(indices.count))
    let letter = keys[indices[Int(random)]]
    letters.append(letter)
    indices.removeAtIndex(Int(random))
  }

  let designatedLetter = letters[0]
  let thisRound = Round(letter: designatedLetter, morseCode: alphaNumToMorse[designatedLetter]!, alternatives:Array(letters[1..<letters.count]))
  return thisRound
}

