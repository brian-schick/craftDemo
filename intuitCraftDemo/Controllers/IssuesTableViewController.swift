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
	var htmlURLString = ""
	var state = IssueState.Open
	var issues = [Issue]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 110
		
		IssuesService.fetch(forRepoName: repoName) { unsortedIssues in
			self.setIssues(unsortedIssues)
		}
	}
	
	
	// MARK: - IB Actions
	@IBAction func gitHubButtonTapped(_ sender: UIButton) {
		guard
			let url = URL(string: htmlURLString),
			UIApplication.shared.canOpenURL(url)
		else { return }
		
		UIApplication.shared.open(url)
	}
	
	
	
	// MARK: - Public Methods
	
	/*
	PLEASE NOTE:
	As with repos, I've used this method as a (hopefully) demo-appropriate means of addressing
	separation of concerns and unit testing-friendly setup.
	*/
	
	public func setIssues(_ issues: [Issue], reloadingTableView shouldReload: Bool = true) {
		self.issues = issues
			.filter { $0.state == self.state }
			.sorted(by: { $0.number > $1.number }) // putting most recent issues at top
		if shouldReload {
			self.tableView.reloadData()
		}
	}
	
	
	// MARK: - TableView Methods
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return issues.count + 1
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		if indexPath.row < issues.count {
			let cell = tableView.dequeueReusableCell(withIdentifier: "Issue", for: indexPath) as! IssuesCell
			populateIssuesCell(cell, forIssue: issues[indexPath.row])
			return cell
		}
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "GitHub", for: indexPath) as! GitHubLinkCell
		return cell
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return "Intuit / " + repoName
	}
	
	
	// MARK: - Private Methods
	private func populateIssuesCell(_ cell: IssuesCell, forIssue issue: Issue) {
		cell.titleLabel.text = issue.title
		cell.numberLabel.text = "#\(issue.number)"
		cell.openedLabel.text = !issue.creator.isEmpty ? "Opened by \(issue.creator) \(issue.createdString)" : "(Creation info not provided)"
		if issue.state == .Closed {
			cell.titleLabel.textColor = .gray
			cell.numberLabel.textColor = .lightGray
			cell.openedLabel.textColor = .lightGray
			cell.stateIcon.tintColor = .lightGray
		}
		
		if let labels = issue.labels {
			for (idx, label) in labels.enumerated() {
				
				let uiLabel: UILabel?
				switch idx {
				case 0: uiLabel = cell.label_0
				case 1: uiLabel = cell.label_1
				case 2: uiLabel = cell.label_2
				case 3: uiLabel = cell.label_3
				case 4: uiLabel = cell.label_4
				default: uiLabel = nil
				}
				
				if let uiLabel = uiLabel {
					uiLabel.text = " \(label.name) "
					uiLabel.layer.backgroundColor = label.color.cgColor
					uiLabel.layer.cornerRadius = 2

					var grayscale: CGFloat = 0
					if label.color.getWhite(&grayscale, alpha: nil) {
						uiLabel.textColor = grayscale < 0.6 ? .white : .black
					}
				}
			}
		}
		
		/*
		PLEASE NOTE:
		
		As noted elsewhere, I initially implemented labels with a standard horizontal UIStackView, but encountered
		unexpected rendering issues when scrolling, and so fell back to working with statically-defined IB template
		label controls and the above (not so elegant) code.
		
		I've left the original stack view code here to show my process.
		*/
		
		//		while cell.labelsStack.arrangedSubviews.count > 0 {
		//			let view = cell.labelsStack.arrangedSubviews[cell.labelsStack.arrangedSubviews.count - 1]
		//			cell.labelsStack.removeArrangedSubview(view)
		//		}
		//
		//		if let labels = issue.labels {
		//			for label in labels {
		//				let uiLabel = UILabel()
		//				uiLabel.text = " \(label.name) "
		//				uiLabel.layer.backgroundColor = label.color.cgColor
		//				uiLabel.layer.cornerRadius = 2
		//
		//				var grayscale: CGFloat = 0
		//				if label.color.getWhite(&grayscale, alpha: nil) {
		//					if grayscale < 0.6 {
		//						uiLabel.textColor = .white
		//					}
		//				}
		//
		//				uiLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
		//				uiLabel.adjustsFontForContentSizeCategory = true
		//				uiLabel.setContentHuggingPriority(UILayoutPriority(1000), for: .horizontal)
		//				cell.labelsStack.addArrangedSubview(uiLabel)
		//			}
		//
		//			let spacer = UILabel()
		//			spacer.backgroundColor = .clear
		//			spacer.text = "  "
		//			spacer.setContentHuggingPriority(UILayoutPriority(0), for: .horizontal)
		//			spacer.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
		//			cell.labelsStack.addArrangedSubview(spacer)
		//		}
	}
}
