//
//  Errors.swift
//  intuitCraftDemo
//
//  Created by Brian Schick on 3/7/20.
//  Copyright © 2020 Brian Schick. All rights reserved.
//

import Foundation

/*
PLEASE NOTE:
The ExampleError enum is a quick bow to what would be a richer, more robust mechanism for any async issues given time.
It has several shortcomiongs as is, including that it's not passed back to the completion handler, and
doesn't include any associated types for error details.
*/

public enum CraftDemoError: Error {
	case repositoryFetchFailure
	case repositoryDecodeFailure
	case issueFetchFailure
	case issueDecodeFailure
}
