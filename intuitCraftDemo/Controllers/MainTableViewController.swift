//
//  MainTableViewController.swift
//  intuitCraftDemo
//
//  Created by Brian Schick on 3/5/20.
//  Copyright © 2020 Brian Schick. All rights reserved.
//

import UIKit

final class MainTableViewController: UITableViewController {
	var repos = [Repository]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView.rowHeight = 110 // using static cell height for demo purposes

		RepositoriesService.fetch { unsortedRepos in
			self.setRepositories(unsortedRepos)
		}
	}
	
	// MARK: - Public Methods
	/*
	PLEASE NOTE:
	I've set up the following public method to both quickly separate concerns and make it easy to insert
	mock data for unit testing.
	*/
	
	public func setRepositories(_ repositories: [Repository], reloadingTableView shouldReload: Bool = true) {
		self.repos = repositories.sorted(by: { $0.name.lowercased() < $1.name.lowercased() })
		if shouldReload {
			self.tableView.reloadData()
		}
	}
	
// MARK: - Private TableView Methods
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return repos.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Repo", for: indexPath) as! MainTableViewCell
		let repo = repos[indexPath.row]
		
		let attributedText = NSMutableAttributedString(
			string: "intuit/",
			attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14, weight: .light)])
		attributedText.append(NSMutableAttributedString(
			string: repo.name,
			attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14, weight: .bold)]))
		cell.repoLabel.attributedText = attributedText
		
		cell.descriptionLabel.text = repo.description
		cell.watcherslabel.text = "\(repo.watchers)"
		cell.languageLabel.text = repo.language
		cell.languageImage.tintColor = repo.languageColor
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return "Intuit"
	}
	
// MARK: - Segues
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		/*
		Please Note:
		For demo purposes, I'm just using simple Apple's default string identifiers. In production, I'd typically either
		use an enumeration or something like an app-wide set of string constants to avoid common stringly-typed issues.
		*/
		guard
			segue.identifier == "MainToIssue",
			let issuesVC = segue.destination as? IssuesTableViewController,
			let selectedRow = tableView.indexPathForSelectedRow?.row
		else { return }
		
		issuesVC.repoName = repos[selectedRow].name
	}
}

