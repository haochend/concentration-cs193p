//
//  ViewController.swift
//  concentration
//
//  Created by David Dong on 2/12/19.
//  Copyright © 2019 David Dong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count+1)/2
    }

    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    private var themes = [0: ["👻", "🎃", "🦇", "🦹‍♂️", "🍎", "🙀"],
                  1: ["🐶", "🐱", "🐭", "🐰", "🦊", "🐻", "🐼"],
                  2: ["🍎", "🍌", "🍓", "🥔", "🥯", "🌭"],
                  3: ["⚽️", "🏀", "🏈", "⚾️", "🎱", "⛸"],
                  4: ["🚗", "🚕", "🚌", "🏎", "🚑", "🚜", "🏍"],
                  5: ["⌚️", "📱", "🖥", "⌨️", "🖱", "💻"]]
    
    private lazy var emojiChoices = themes[themes.count.arc4random]!
    
    private var emoji = Dictionary<Card, String>()
    
    @IBAction private func newGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count+1)/2)
        emojiChoices = themes[Int(arc4random_uniform(UInt32(themes.count)))]!
        updateViewFromModel()
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("there is sth wrong")
        }
        
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        flipCountLabel.text = "Flips: \(game.flipCount) Score: \(game.score)"
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil {
            if emojiChoices.count > 0 {
                emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
            }
        }
        return emoji[card] ?? "?"
    }
    
//    func flipCard(withEmoji emoji: String, on button: UIButton) {
//        if button.currentTitle == emoji {
//            button.setTitle("", for: UIControl.State.normal)
//            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
//        } else {
//            button.setTitle(emoji, for: UIControl.State.normal)
//            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        }
//    }
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

