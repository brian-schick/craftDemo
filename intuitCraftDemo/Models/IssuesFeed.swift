//
//  IssuesFeed.swift
//  intuitCraftDemo
//
//  Created by Brian Schick on 3/7/20.
//  Copyright © 2020 Brian Schick. All rights reserved.
//

import Foundation

public struct IssuesFeed: Decodable {
	public let issues: [Issue]
	
	public init(from decoder: Decoder) throws {
		var container = try decoder.unkeyedContainer()
		var aggregatedIssues = [Issue]()
		while let id = try? container.decode(Issue.self) {
			aggregatedIssues.append(id)
		}
		issues = aggregatedIssues
	}
}
