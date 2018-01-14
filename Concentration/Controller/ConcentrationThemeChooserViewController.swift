//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Chris Huang on 14/01/2018.
//  Copyright © 2018 Chris Huang. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {
	
	// MARK: UISplitViewControllerDelegate
	
	override func awakeFromNib() {
		super.awakeFromNib()
		splitViewController?.delegate = self
	}
	
	// to keep primaryViewController on top for iPhone
	func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
		if let concentrationViewController = secondaryViewController as? ConcentrationViewController {
			if concentrationViewController.theme == nil {
				return true
			}
		}
		return false
	}
	
	// MARK: Model
	
	let themes = [
		"Sports": "⚽️🏀🏈⚾️🎾🏐🎱🏓🏂⛷🏄‍♂️🚴‍♂️",
		"Animals": "🦓🦖🐁🐇😸🐖🐘🐝🐞🐶🐼🦄",
		"Faces": "😀😡😎😘😤😱😷👺🤠😴😭🤢"
	]
	
	// MARK: Properties
	
	// for iPad: to check out master view controller
	private var splitViewDetailConcentrationViewController: ConcentrationViewController? {
		return splitViewController?.viewControllers.first as? ConcentrationViewController
	}
	
	// for iPhone: to keep last view controller in the heap
	private var lastSeguedToConcentrationViewController: ConcentrationViewController?
	
	// MARK: Storyboard
	
	/* Conditional segue: change theme on the fly */
	@IBAction func changeTheme(_ sender: Any) {
		// for iPad in UISplitViewController
		if let concentrationViewController = splitViewDetailConcentrationViewController {
			if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
				concentrationViewController.theme = theme
			}
		// for iPhone in UINavigationController
		} else if let concentrationViewController = lastSeguedToConcentrationViewController {
			if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
				concentrationViewController.theme = theme
			}
			navigationController?.pushViewController(concentrationViewController, animated: true)
		} else {
			// segue in code, still need to connect segue from VC to VC
			performSegue(withIdentifier: "ChooseTheme", sender: sender)
		}
	}
	
	// MARK: Navigations
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "ChooseTheme" {
			if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
				if let concentrationViewController = segue.destination as? ConcentrationViewController {
					concentrationViewController.theme = theme
					lastSeguedToConcentrationViewController = concentrationViewController
				}
			}
		}
	}
}
