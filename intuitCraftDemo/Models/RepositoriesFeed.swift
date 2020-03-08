//
//  RepositoriesFeed.swift
//  intuitCraftDemo
//
//  Created by Brian Schick on 3/5/20.
//  Copyright © 2020 Brian Schick. All rights reserved.
//

import Foundation

public struct RepositoriesFeed: Decodable {
	let repos: [Repository]
	
	/*
	PLEASE NOTE:
	
	Since Codable expects JSON properties to be labeled and GitHub's API exposes raw unlabled elements,
	this initializer was required. I leveraged an UnkeyedDecodingContainer to work around the "missing"
	JSON labels. Interestingly, Codable wouldn't directly decode to an array within an unkeyed container.
	I'd like to investigate this behavior further, but for this demo I used a simple while let loop to
	manually aggregate all nested repositories.
	*/
	
	public init(from decoder: Decoder) throws {
		var container = try decoder.unkeyedContainer()
		var aggregatedRepos = [Repository]()
		
		while let repo = try? container.decode(Repository.self) {
			aggregatedRepos.append(repo)
		}
		
		repos = aggregatedRepos
	}
}
