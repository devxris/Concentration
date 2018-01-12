//
//  ViewController.swift
//  Concentration
//
//  Created by Chris Huang on 12/01/2018.
//  Copyright © 2018 Chris Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	// MARK: Properties
	
	var flipCount = 0 {
		didSet {
			flipCountLabel.text = "Flips: \(flipCount)"
		}
	}
	
	var emojiChoices = ["🎃", "👻", "🎃", "👻"]
	
	// MARK: Storyboardz
	
	@IBOutlet weak var flipCountLabel: UILabel!
	@IBOutlet var cardButtons: [UIButton]!
	
	@IBAction func touchCard(_ sender: UIButton) {
		flipCount += 1
		if let cardNumber = cardButtons.index(of: sender) {
			flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
		} else {
			print("chosen card was not in cardButtons")
		}
	}
	
	// MARK: Funcs
	
	func flipCard(withEmoji emoji: String, on button: UIButton) {
		if button.currentTitle == emoji {
			button.setTitle("", for: .normal)
			button.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
		} else {
			button.setTitle(emoji, for: .normal)
			button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
		}
	}
}
