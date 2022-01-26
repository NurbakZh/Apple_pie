//
//  Game.swift
//  Apple Pie
//
//  Created by mac on 26.01.2022.
//

import Foundation

struct Game {
    var word: String
    var incorrectMovesRemaining: Int
    var guessedLetter: [Character]
    mutating func play(guess: Character) {
        guessedLetter.append(guess)
        if(!word.contains(guess)) {
            incorrectMovesRemaining -= 1
        }
    }
    var formattedWord: String {
        var worde = ""
        for letter in word.lowercased() {
            if(guessedLetter.contains(letter)) {
                worde += String(letter)
            } else {
                worde += "_"
            }
        }
        return worde
    }
}
