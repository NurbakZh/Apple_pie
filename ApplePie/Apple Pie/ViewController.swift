//
//  ViewController.swift
//  Apple Pie
//
//  Created by mac on 26.01.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var listOfWords = ["Abay", "Kerey","Zhanibek","Abylai","Tokayev",
                       "Nurbek","IOS","coding","swift","software"]
    let incorrectMovesAllowed = 7
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLoses = 0 {
        didSet {
            newRound()
        }
    }
    
    @IBOutlet var treeImageView: UIImageView!
    @IBOutlet var correctWordLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    var currentGame: Game!
    
    func newRound() {
        if(!listOfWords.isEmpty) {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining:incorrectMovesAllowed, guessedLetter: [])
            updateButtons(true)
            updateUI()
        } else {
            updateButtons(false)
            
        }
        
    }
    
    func updateButtons(_ state: Bool) {
        for button in letterButtons {
            button.isEnabled = state
        }
    }
    
    func updateUI() {
        var wordWithSpaces = [String]()
        for letter in currentGame.formattedWord {
            wordWithSpaces.append(String(letter))
        }
        correctWordLabel.text = wordWithSpaces.joined(separator: " ")
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLoses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    func updateGameResult() {
        if(currentGame.incorrectMovesRemaining == 0) {
            totalLoses += 1
        } else if(currentGame.word.lowercased() == currentGame.formattedWord.lowercased()) {
            totalWins += 1
        } else {
            updateUI()
        }
    }
    
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.configuration!.title!
        let letter = Character(letterString.lowercased())
        currentGame.play(guess: letter)
        updateGameResult()
    }
    
    
}

