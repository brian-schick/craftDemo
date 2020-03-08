//
//  IssuesService.swift
//  intuitCraftDemo
//
//  Created by Brian Schick on 3/7/20.
//  Copyright © 2020 Brian Schick. All rights reserved.
//

import UIKit

public enum IssuesService {
	
	/*
	PLEASE NOTE:
	
	I was going to make this a caching service, thinking we'd want to cache issues
	(and for that matter, repos upstream as well) to minimize network traffic and
	improve response time.
	
	So, I started setting up a simple mechanism
	(e.g. `private static let cache = NSCache<NSString, Issue>()`) but realized
	we'd need to define how often to get fresh data, decide if we wanted GUI
	afordances like pull to refresh, etc, and that this was beyond demo scope.
	*/
	
	private typealias TaskClosureElements = (data: Data?, response: URLResponse?, error: Error?)
	private static let session = URLSession(configuration: .default)
	private static var dataTask: URLSessionDataTask?
	
	public static func fetch(forRepoName repoName: String, completionHandler: @escaping ([Issue]) -> ()) {
		dataTask?.cancel()
		
				let fullURLString = "https://api.github.com/repos/intuit/"
					+ repoName
					+ "/issues?client_id=Iv1.ecccdfd29ea3958a&client_secret=68d466288e850672dd3bc70a825fc0c6c183f7b9"
				guard let url = URL(string: fullURLString) else {
					print("Can't get valid URL") // Simply printing this out for time's sake
					return
				}
		
		dataTask = session.dataTask(with: url) { data, response, error in
			defer { self.dataTask = nil }
			
			guard
				let data = try? retrievedData(for: (data, response, error)),
				let issues = try? decode(data)
				else {
					print("Can't retrieve or decode issues") // Simply printing this out for time's sake
					return
			}
			
			DispatchQueue.main.async {
				completionHandler(issues)
			}
		}
		
		dataTask?.resume()
	}
	
	
	// MARK: - Private Support Methods
	private static func retrievedData(for closureElements: TaskClosureElements) throws -> Data {
		guard
			closureElements.error == nil,
			let data = closureElements.data
			else {
				throw CraftDemoError.repositoryFetchFailure
		}
		return data
	}
	
	private static func decode(_ data: Data) throws -> [Issue] {
		do {
			let decoder = JSONDecoder()
			decoder.keyDecodingStrategy = .convertFromSnakeCase
			decoder.dateDecodingStrategy = .iso8601
			let feed = try decoder.decode(IssuesFeed.self, from: data)
			
			return feed.issues
		} catch {
			throw CraftDemoError.repositoryDecodeFailure
		}
	}
}
