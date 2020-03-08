//
//  IssuesTableViewController.swift
//  intuitCraftDemo
//
//  Created by Brian Schick on 3/8/20.
//  Copyright © 2020 Brian Schick. All rights reserved.
//

import UIKit

final class IssuesTableViewController: UITableViewController {
	var repoName = ""
	var issues = [Issue]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		print("Repo name: \(repoName)")
		// get data dynamically
	}
}
