//
//  Repository.swift
//  intuitCraftDemo
//
//  Created by Brian Schick on 3/6/20.
//  Copyright © 2020 Brian Schick. All rights reserved.
//

import Foundation

public struct Repository: Decodable {
	public let name: String
	public let description: String
	public let watchersCount: Int
	public let language: String
}
