//
//  IssueState.swift
//  intuitCraftDemo
//
//  Created by Brian Schick on 3/8/20.
//  Copyright © 2020 Brian Schick. All rights reserved.
//

import Foundation

public enum IssueState: String, Codable {
	case Open = "open"
	case Closed = "closed"
}
