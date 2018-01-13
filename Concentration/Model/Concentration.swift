//
//  Concentration.swift
//  Concentration
//
//  Created by Chris Huang on 13/01/2018.
//  Copyright © 2018 Chris Huang. All rights reserved.
//

import Foundation

class Concentration {
	
	var cards = [Card]() // store property
	var indexOfIneAndOnlyFaceUpCard: Int? { // computed property
		get {
			var foundIndex: Int?
			for index in cards.indices {
				if cards[index].isFaceUp {
					if foundIndex == nil {
						foundIndex = index
					} else {
						return nil
					}
				}
			}
			return foundIndex
		}
		set {
			for index in cards.indices { // turn cards back down except the chosing one
				cards[index].isFaceUp = (index == newValue)
			}
		}
	}
	
	init(numberOfParisOfCards: Int) {
		for _ in 0..<numberOfParisOfCards {
			let card = Card()
			cards += [card, card]
		}
		// TODO: Suffle the cards
	}
	
	func chooseCard(at index: Int) { // game logic
		// 3 options: all face down, one up not matched, one up matched
		if !cards[index].isMatched {
			if let matchIndex = indexOfIneAndOnlyFaceUpCard, matchIndex != index {
				// check if cards matched
				if cards[matchIndex].identifier == cards[index].identifier {
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
