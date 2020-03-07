//
//  Repository.swift
//  intuitCraftDemo
//
//  Created by Brian Schick on 3/6/20.
//  Copyright © 2020 Brian Schick. All rights reserved.
//

import UIKit

public struct Repository: Decodable {
	public let name: String
	public let description: String
	public let language: String
	public let watchers: Int
	
	public var languageColor: UIColor {
		return UIColor(hexString: languageHexColor) ?? UIColor.githubFallbackColor
	}
	
	// MARK: - Custom Coding Key
	private enum CodingKeys: String, CodingKey {
		case name = "name"
		case description = "description"
		case language = "language"
		// custom key
		case watchers = "watchersCount"
	}
}

// MARK: - Repository Language Color Extension
	/*
	PLEASE NOTE:

	I've moved quickly here for demo purposes.

	I located an exhaustive listing of GitHub language hx colors at https://github.com/IonicaBizau/github-colors/blob/HEAD/colors.md
	
	To avoid building up too much for a short demo, I simply created a distinct list of languages currently in use by Intuit
	and created a calculated languageHexColor property in the extension below, adding an arbitrary medium gray color to handle
	any unexpected languages we might encounter.

	Next, since we'll need to work with hex colors for Issue labels as well, I added a UIColor+.swift extension to ease creation of
	UIColors directly from hex values.

	Last, I made languageHexColor a private property, adding a public languageColor of type UIColor to the public API.
	*/

extension Repository {
	private var languageHexColor: String {
		switch language {
		case "Go" : return "#375eab"
		case "JavaScript" : return "#f1e05a"
		case "Objective-C" : return "#438eff"
		case "R" : return "#198CE7"
		case "Ruby" : return "#701516"
		default : return "#666666"
		}
	}
}
