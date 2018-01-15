//
//  ConcentrationViewController.swift
//  Concentration
//
//  Created by Chris Huang on 12/01/2018.
//  Copyright © 2018 Chris Huang. All rights reserved.
//

import UIKit

class ConcentrationViewController: VCLLoggingViewController {
	
	// MARK: VCLLoggingViewController
	override var vclLoggingName: String { return "Game" }
		
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
	
	// along with autolayout and replace original cardButtons, needs to notify viewDidLayoutSubviews to update model
	private var visibleCardButtons: [UIButton]! {
		return cardButtons?.filter { !$0.superview!.isHidden }
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		updateViewsFromModel()
	}
	
	@IBAction private func touchCard(_ sender: UIButton) {
		flipCount += 1
		if let cardNumber = visibleCardButtons.index(of: sender) {
			game.chooseCard(at: cardNumber)
			updateViewsFromModel()
			
		} else {
			print("chosen card was not in visibleCardButtons")
		}
	}
	
	// MARK: Private Funcs
	
	private func updateViewsFromModel() {
		if visibleCardButtons != nil { // ensure visibleCardButtons are set before prepare(for segue)
			for index in visibleCardButtons.indices {
				let button = visibleCardButtons[index]
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
		let attributedString = NSAttributedString( // need to notify traitCollectionDidChange to update label
			string: traitCollection.verticalSizeClass == .compact ? "Flip\n\(flipCount)" : "Flips: \(flipCount)",
			attributes: attributes)
		flipCountLabel.attributedText = attributedString
	}
	
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)
		updateFlipCountLabel()
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
