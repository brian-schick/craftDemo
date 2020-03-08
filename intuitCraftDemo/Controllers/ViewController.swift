//
//  ViewController.swift
//  intuitCraftDemo
//
//  Created by Brian Schick on 3/5/20.
//  Copyright © 2020 Brian Schick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	var repositories = [Repository]()

	override func viewDidLoad() {
		super.viewDidLoad()

		RepositoriesService.fetch { repos in
			self.repositories = repos
			
			
			// TODO: update table view and remove debug code
			for repo in repos {
				print("language: \(repo.language), color: \(repo.languageColor)")
			}
		}
		
		
	}


}

