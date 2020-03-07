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
	
	public init(from decoder: Decoder) throws {
		var container = try decoder.unkeyedContainer()
		var aggregatedRepos = [Repository]()
		while let repo = try? container.decode(Repository.self) {
			aggregatedRepos.append(repo)
		}
		repos = aggregatedRepos
	}
}
