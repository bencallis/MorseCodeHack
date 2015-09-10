//
//  GameEngine.swift
//  MorseCodeEngine
//
//  Created by Weingarten, Benny on 9/10/15.
//  Copyright © 2015 MorseTeam. All rights reserved.
//

import Foundation

let alphaNumToMorse = [
  "A": ".-",
  "B": "-...",
  "C": "-.-.",
  "D": "-..",
  "E": ".",
  "F": "..-.",
  "G": "--.",
  "H": "....",
  "I": "..",
  "J": ".---",
  "K": "-.-",
  "L": ".-..",
  "M": "--",
  "N": "-.",
  "O": "---",
  "P": ".--.",
  "Q": "--.-",
  "R": ".-.",
  "S": "...",
  "T": "-",
  "U": "..-",
  "V": "...-",
  "W": ".--",
  "X": "-..-",
  "Y": "-.--",
  "Z": "--..",
  "a": ".-",
  "b": "-...",
  "c": "-.-.",
  "d": "-..",
  "e": ".",
  "f": "..-.",
  "g": "--.",
  "h": "....",
  "i": "..",
  "j": ".---",
  "k": "-.-",
  "l": ".-..",
  "m": "--",
  "n": "-.",
  "o": "---",
  "p": ".--.",
  "q": "--.-",
  "r": ".-.",
  "s": "...",
  "t": "-",
  "u": "..-",
  "v": "...-",
  "w": ".--",
  "x": "-..-",
  "y": "-.--",
  "z": "--..",
  "1": ".----",
  "2": "..---",
  "3": "...--",
  "4": "....-",
  "5": ".....",
  "6": "-....",
  "7": "--...",
  "8": "---..",
  "9": "----.",
  "0": "-----",
]


struct Round {
  var letter: String
  var morseCode: String
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
