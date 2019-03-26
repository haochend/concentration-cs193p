//
//  concentration.swift
//  concentration
//
//  Created by David Dong on 2/13/19.
//  Copyright © 2019 David Dong. All rights reserved.
//

import Foundation

class Concentration {
    
    private(set) var cards = [Card]()
    
    var flipCount = 0, score = 0
    
    private var indexOfOneAndOnlyFacedUp: Int?
    {
        get {
            let faceUpIndices = cards.indices.filter { cards[$0].isFaceUp }
            return faceUpIndices.count == 1 ? faceUpIndices.first : nil
//            var foundIndex: Int?
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    if foundIndex == nil {
//                        foundIndex = index
//                    } else {
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        set {
            for index in cards.indices {
                if cards[index].isFaceUp {
                    cards[index].wasSeen = true
                }
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index): chosen index not in the cards")
        flipCount += 1
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFacedUp, matchIndex != index {
                if cards[index] == cards[matchIndex] {
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                    score += 2
                } else {
                    if cards[index].wasSeen == true {
                        score -= 1
                    }
                    if cards[matchIndex].wasSeen == true {
                        score -= 1
                    }
                }
                cards[index].isFaceUp = true
//                indexOfOneAndOnlyFacedUp = nil
            } else {
//                for flipDownIndex in cards.indices {
//                    if cards[flipDownIndex].isFaceUp == true {
//                        cards[flipDownIndex].wasSeen = true
//                    }
//                    cards[flipDownIndex].isFaceUp = false
//                }
//                cards[index].isFaceUp = true
                indexOfOneAndOnlyFacedUp = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards): number of pairs of cards must be positive")
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards.append(card)
            cards.append(card)
        }
        cards.shuffle()
    }
}
