//
//  Card.swift
//  Concentration
//
//  Created by Chris Huang on 13/01/2018.
//  Copyright © 2018 Chris Huang. All rights reserved.
//

import Foundation

struct Card {
	
	var isFaceUp = false
	var isMatched = false
	var identifier: Int = 0
	
	private static var identifierFactory = 0
	private static func getUniqueIdentifier() -> Int {
		identifierFactory += 1 // both in static method, no need to specify "Card."identifierFactory
		return identifierFactory
	}
	
	init() {
		self.identifier = Card.getUniqueIdentifier()
	}
}
