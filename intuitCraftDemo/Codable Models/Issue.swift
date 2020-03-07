//
//  Issue.swift
//  intuitCraftDemo
//
//  Created by Brian Schick on 3/7/20.
//  Copyright © 2020 Brian Schick. All rights reserved.
//

import Foundation

public struct Issue: Decodable {
	public let title: String
	public let number: Int
	public let state: IssueState
	
	private let labels: [Label]
	private let milestone: Milestone
	
	public var creator: String {
		self.milestone.creator.login
	}
	
//	public var tags: // complete this
	public var created: String {
		self.milestone.createdAt.sinceNow
	}
}

// MARK: - Supporting Types for Issue

public enum IssueState: String, Codable {
	case Open = "open"
	case Closed = "closed"
}

struct Label: Decodable {
	let name: String
	let color: String
}

struct Milestone: Decodable {
	let createdAt: Date
	let creator: Creator
}

struct Creator: Decodable {
	let login: String
}
