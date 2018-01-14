//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Chris Huang on 14/01/2018.
//  Copyright © 2018 Chris Huang. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController {
	
	// MARK: Model
	
	let themes = [
		"Sports": "⚽️🏀🏈⚾️🎾🏐🎱🏓🏂⛷🏄‍♂️🚴‍♂️",
		"Animals": "🦓🦖🐁🐇😸🐖🐘🐝🐞🐶🐼🦄",
		"Faces": "😀😡😎😘😤😱😷👺🤠😴😭🤢"
	]
	
	// MARK: Storyboard
	
	// segue in code, still need to connect segue from VC to VC
	@IBAction func changeTheme(_ sender: Any) { performSegue(withIdentifier: "ChooseTheme", sender: sender) }
	
	// MARK: Navigations
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "ChooseTheme" {
			if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
				if let cvc = segue.destination as? ConcentrationViewController {
					cvc.theme = theme
				}
			}
		}
	}
}
