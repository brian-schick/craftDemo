//
//  RepositoriesService.swift
//  intuitCraftDemo
//
//  Created by Brian Schick on 3/7/20.
//  Copyright © 2020 Brian Schick. All rights reserved.
//

import UIKit

public enum RepositoriesService {
	
	private typealias TaskClosureElements = (data: Data?, response: URLResponse?, error: Error?)
	private static let url = URL(string: "https://api.github.com/orgs/intuit/repos?client_id=Iv1.ecccdfd29ea3958a&client_secret=68d466288e850672dd3bc70a825fc0c6c183f7b9")!
	private static let session = URLSession(configuration: .default)
	private static var dataTask: URLSessionDataTask?
	
	public static func fetch(completionHandler: @escaping ([Repository]) -> ()) {
		dataTask?.cancel()
		
		dataTask = session.dataTask(with: url) { data, response, error in
			defer { self.dataTask = nil }
			
			guard
				let data = try? retrievedData(for: (data, response, error)),
				let repos = try? decode(data)
				else {
					print("Can't retrieve or decode repos") // Simply printing this out for time's sake
					return
			}
			
			DispatchQueue.main.async {
				completionHandler(repos)
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
	
	private static func decode(_ data: Data) throws -> [Repository] {
		do {
			let decoder = JSONDecoder()
			decoder.keyDecodingStrategy = .convertFromSnakeCase
			let feed = try decoder.decode(RepositoriesFeed.self, from: data)

			return feed.repos
		} catch {
			throw CraftDemoError.repositoryDecodeFailure
		}
	}
}
