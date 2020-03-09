//
//  Repository.swift
//  intuitCraftDemo
//
//  Created by Brian Schick on 3/6/20.
//  Copyright © 2020 Brian Schick. All rights reserved.
//

import UIKit

/*
PLEASE NOTE:
I've made this a class to enable caching via NSCache. Otherwise, this could be a struct.
*/

public struct Repository: Decodable {
	
	// MARK: - Codable Properties
	public let name: String
	public let description: String
	public let watchers: Int
	public let htmlURL: String
	private let maybeLanguage: String?
	
	
	// MARK: - Public Computed Properties
	public var language: String {
		return maybeLanguage ?? "(Undefined)"
	}
	public var languageColor: UIColor {
		return UIColor(hexString: languageHexColor) ?? UIColor.githubFallbackColor
	}
	
	
	// MARK: - Coding Keys
	private enum CodingKeys: String, CodingKey {
		case name = "name"
		case description = "description"
		case htmlURL = "htmlUrl"
		
		case maybeLanguage = "language"
		case watchers = "watchersCount"
	}
}

// MARK: - Repository Language Color Extension

/*
PLEASE NOTE:

I've moved quickly here for demo purposes.

After locating a listing of GitHub language hx colors at https://github.com/IonicaBizau/github-colors/blob/HEAD/colors.md,
I grabbed a distinct list of languages currently in use by Intuit and created a calculated languageHexColor property
in the extension below, adding handling for any unexpected values.

Next, since we'll also need to work with hex colors for Issue labels as well, I added a UIColor+.swift extension to ease
creation of UIColors from hex values.

Last, I made languageHexColor a private property and added a public languageColor of type UIColor to the public API.
*/

extension Repository {
	private var languageHexColor: String {
		switch language {
		case "C#"         : return "#178600"
		case "Go"         : return "#375eab"
		case "Java"       : return "#b07219"
		case "JavaScript" : return "#f1e05a"
		case "Objective-C": return "#438eff"
		case "PHP"        : return "#4F5D95"
		case "R"          : return "#198CE7"
		case "Ruby"       : return "#701516"
		case "Swift"      : return "#ffac45"
		default           : return "#666666"
		}
	}
}
