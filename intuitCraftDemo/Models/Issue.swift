//
//  Issue.swift
//  intuitCraftDemo
//
//  Created by Brian Schick on 3/7/20.
//  Copyright © 2020 Brian Schick. All rights reserved.
//

import UIKit

/*
PLEASE NOTE:
I've made this a class to enable caching via NSCache. Otherwise, this could be a struct.
*/

public final class Issue: Decodable {
	
	public enum IssueState: String, Codable {
		case Open = "open"
		case Closed = "closed"
	}
	
	// MARK: - Public Codable Properties
	public let title: String
	public let number: Int
	public let state: IssueState
	
	// MARK: - Private Codable Properties
	private let labels: [Label]
	private let milestone: Milestone
	
	// MARK: - Public Computed Properties
	public var creator: String {
		self.milestone.creator.login
	}
	
	public var createdString: String {
		self.milestone.createdAt.sinceNow
	}
}

// MARK: - Public Supporting Types

/*
PLEASE NOTE: As with Issue Label Colors, I'm again exposing only a UIColor publicly,
rather than the raw hex color provided by GitHub.
*/

public struct Label: Decodable {
	let name: String
	private let hexColor: String
	
	public var color: UIColor {
		return UIColor(hexString: hexColor) ?? UIColor.githubFallbackColor
	}
	
	private enum CodingKeys: String, CodingKey {
		case name = "name"
		case hexColor = "color"
	}
}

// MARK: - Private Supporting Types
private struct Milestone: Decodable {
	let createdAt: Date
	let creator: Creator
}

private struct Creator: Decodable {
	let login: String
}
