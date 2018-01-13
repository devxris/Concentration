//
//  ViewController.swift
//  Concentration
//
//  Created by Chris Huang on 12/01/2018.
//  Copyright © 2018 Chris Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	// MARK: Model
	
	private lazy var game = Concentration(numberOfParisOfCards: self.numberOfParisOfCards) // Can't user property observers
	
	// MARK: Properties
	
	var numberOfParisOfCards: Int { return (cardButtons.count + 1) / 2 } // read-only computed property
	
	private(set) var flipCount = 0 { didSet { flipCountLabel.text = "Flips: \(flipCount)" } }
	
	var emojiChoices = ["🎃", "👻", "👿", "🙀", "🦇", "🍎", "🍭", "🍬", "😱"]
	var emoji = [Int: String]()
	
	// MARK: Storyboard
	
	@IBOutlet private weak var flipCountLabel: UILabel!
	@IBOutlet private var cardButtons: [UIButton]!
	
	@IBAction private func touchCard(_ sender: UIButton) {
		flipCount += 1
		if let cardNumber = cardButtons.index(of: sender) {
			game.chooseCard(at: cardNumber)
			updateViewsFromModel()
			
		} else {
			print("chosen card was not in cardButtons")
		}
	}
	
	// MARK: Private Funcs
	
	private func updateViewsFromModel() {
		for index in cardButtons.indices {
			let button = cardButtons[index]
			let card = game.cards[index]
			if card.isFaceUp {
				button.setTitle(emoji(for: card), for: .normal)
				button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
			} else {
				button.setTitle("", for: .normal)
				button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
			}
		}
	}
	
	private func emoji(for card: Card) -> String {
		if emoji[card.identifier] == nil, emojiChoices.count > 0 {
			emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
		}
		return emoji[card.identifier] ?? "?"
	}
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
