//
//  card.swift
//  concentration
//
//  Created by David Dong on 2/13/19.
//  Copyright © 2019 David Dong. All rights reserved.
//

import Foundation

struct Card: Hashable {
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var hashValue: Int { return identifier }
    
    var isFaceUp = false
    var isMatched = false
    var wasSeen = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
