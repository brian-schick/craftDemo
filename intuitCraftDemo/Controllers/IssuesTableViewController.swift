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
		self.tableView.rowHeight = 110 // using static cell height for demo purposes

		IssuesService.fetch(forRepoName: repoName) { unsortedIssues in
			self.setIssues(unsortedIssues)
		}
	}
	
	// MARK: - Public Methods
	
	/*
	PLEASE NOTE:
	As with repos, I've used this method as a (hopefully) demo-appropriate means of addressing
	separation of concerns and unit testing-friendly setup.
	*/
	
	public func setIssues(_ issues: [Issue], reloadingTableView shouldReload: Bool = true) {
		self.issues = issues.sorted(by: { $0.number > $1.number }) // putting most recent issues at top
		if shouldReload {
			self.tableView.reloadData()
		}
	}
	
	// MARK: - TableView Methods
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return issues.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Issue", for: indexPath) as! IssuesTableViewCell
		let issue = issues[indexPath.row]

		cell.titleLabel.text = issue.title
		cell.numberLabel.text = "#\(issue.number)"
		cell.openedLabel.text = "Opened by \(issue.creator) \(issue.createdString)"
		if issue.state == .Closed {
			cell.stateIcon.tintColor = UIColor.red
		}
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return "Intuit/" + repoName
	}
}
