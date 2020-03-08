//
//  IssuesCache.swift
//  intuitCraftDemo
//
//  Created by Brian Schick on 3/7/20.
//  Copyright © 2020 Brian Schick. All rights reserved.
//

import UIKit

//public enum IssuesCache {
//
//	private static let cache = NSCache<NSString, Issue>()
//
//	public static func issue(forKey key: String, completionHandler: @escaping(Issue) -> Void) {
//
//		// immediately return cached issue if present
//		if let issue = cache.object(forKey: NSString(string: key)) {
//			completionHandler(issue)
//			return
//		}
//		let fullURLString = "https://api.github.com/orgs/intuit/" + key
//			+ "/issues?client_id=Iv1.ecccdfd29ea3958a&client_secret=68d466288e850672dd3bc70a825fc0c6c183f7b9"
//		guard let url = URL(string: fullURLString) else {
//			print("Can't get valid URL") // Simply printing this out for time's sake
//			return
//		}
//
//		let request = URLRequest(url: url)
//		let session = URLSession.shared
//		let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
//			guard error == nil, let data = data else {
//				print("Can't get issue data from endpoint") // Simply printing this out for time's sake
//				return
//			}
//
//			// decode issue, set cache, pass off to completionHandler
//			cache.setObject(issue, forKey: NSString(string: key))
//		}
//
//
//	}
//}
