//
//  ConcentrationViewController.swift
//  Concentration
//
//  Created by Chris Huang on 12/01/2018.
//  Copyright © 2018 Chris Huang. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
	
	// MARK: Model
	
	private lazy var game = Concentration(numberOfParisOfCards: self.numberOfParisOfCards) // Can't user property observers
	
	// MARK: Properties
	
	var numberOfParisOfCards: Int { return (cardButtons.count + 1) / 2 } // read-only computed property
	
	var theme: String? {
		didSet {
			emojiChoices = theme ?? ""
			emoji = [:]
			updateViewsFromModel()
		}
	}
	
	private(set) var flipCount = 0 { didSet { updateFlipCountLabel() } } // property observer didn't set didSet when first time value assigned
	
	private var emojiChoices = "🎃👻👿🙀🦇🍎🍭🍬😱"
	private var emoji = [Card: String]() // Card conforms th Hashable
	
	// MARK: Storyboard
	
	@IBOutlet private weak var flipCountLabel: UILabel! { didSet { updateFlipCountLabel() } }
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
		if cardButtons != nil { // ensure cardButtons are set before prepare(for segue)
			for index in cardButtons.indices {
				let button = cardButtons[index]
				let card = game.cards[index]
				if card.isFaceUp {
					button.setTitle(emoji(for: card), for: .normal)
					button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
				} else {
					button.setTitle("", for: .normal)
					button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) : #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
				}
			}
		}
	}
	
	private func updateFlipCountLabel() {
		let attributes: [NSAttributedStringKey: Any] = [
			.strokeWidth: 5.0,
			.strokeColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
		]
		let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
		flipCountLabel.attributedText = attributedString
	}
	
	private func emoji(for card: Card) -> String {
		if emoji[card] == nil, emojiChoices.count > 0 {
			let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
			emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
		}
		return emoji[card] ?? "?"
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
