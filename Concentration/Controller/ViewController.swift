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
	
	lazy var game = Concentration(numberOfParisOfCards: self.numberOfParisOfCards) // Can't user property observers
	
	// MARK: Properties
	
	var numberOfParisOfCards: Int { return (cardButtons.count + 1) / 2 } // read-only computed property
	
	var flipCount = 0 {
		didSet {
			flipCountLabel.text = "Flips: \(flipCount)"
		}
	}
	
	var emojiChoices = ["🎃", "👻", "👿", "🙀", "🦇", "🍎", "🍭", "🍬", "😱"]
	var emoji = [Int: String]()
	
	// MARK: Storyboardz
	
	@IBOutlet weak var flipCountLabel: UILabel!
	@IBOutlet var cardButtons: [UIButton]!
	
	@IBAction func touchCard(_ sender: UIButton) {
		flipCount += 1
		if let cardNumber = cardButtons.index(of: sender) {
			game.chooseCard(at: cardNumber)
			updateViewsFromModel()
			
		} else {
			print("chosen card was not in cardButtons")
		}
	}
	
	// MARK: Funcs
	
	func updateViewsFromModel() {
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
	
	func emoji(for card: Card) -> String {
		if emoji[card.identifier] == nil, emojiChoices.count > 0 {
			let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
			emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
		}
		return emoji[card.identifier] ?? "?"
	}
}
