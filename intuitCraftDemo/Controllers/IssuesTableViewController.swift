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
		
		IssuesService.fetch(forRepoName: repoName) { unsortedIssues in
			self.setIssues(unsortedIssues)
		}
	}
	
	// MARK: - Public Methods
	
	/*
	PLEASE NOTE:
	I've set up the following public method to both quickly separate concerns and make it easy to insert
	mock data for unit testing.
	*/
	
	public func setIssues(_ issues: [Issue], reloadingTableView shouldReload: Bool = true) {
		self.issues = issues.sorted(by: { $0.number > $1.number }) // putting most recent issues at top
		if shouldReload {
			self.tableView.reloadData()
		}
	}
}
