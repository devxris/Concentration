//
//  Concentration.swift
//  Concentration
//
//  Created by Chris Huang on 13/01/2018.
//  Copyright © 2018 Chris Huang. All rights reserved.
//

import Foundation

struct Concentration {
	
	private(set) var cards = [Card]() // store property
	
	private var indexOfIneAndOnlyFaceUpCard: Int? { // computed property
		get {
			return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
		}
		set {
			for index in cards.indices { // turn cards back down except the chosing one
				cards[index].isFaceUp = (index == newValue)
			}
		}
	}
	
	init(numberOfParisOfCards: Int) {
		
		assert(numberOfParisOfCards > 0, "Concentration.init(\(numberOfParisOfCards)): You must have at least one pair of cards.")
		
		for _ in 0..<numberOfParisOfCards {
			let card = Card()
			cards += [card, card]
		}
		// TODO: Suffle the cards
	}
	
	mutating func chooseCard(at index: Int) { // game logic
		
		assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index): chosen index not in the cards.")
		
		// 3 options: all face down, one up not matched, one up matched
		if !cards[index].isMatched {
			if let matchIndex = indexOfIneAndOnlyFaceUpCard, matchIndex != index {
				// check if cards matched
				if cards[matchIndex] == cards[index] { // Card conforms to Equatable
					cards[matchIndex].isMatched = true
					cards[index].isMatched = true
				}
				cards[index].isFaceUp = true
			} else {
				// either no cards or 2 cards are face up
				indexOfIneAndOnlyFaceUpCard = index
			}
		}
	}
}

extension Collection {
	var oneAndOnly: Element? { return count == 1 ? first : nil } // Element is a generic type in Collection
}
