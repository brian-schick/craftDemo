//
//  IssuesTableViewCell.swift
//  intuitCraftDemo
//
//  Created by Brian Schick on 3/8/20.
//  Copyright © 2020 Brian Schick. All rights reserved.
//

import UIKit

final public class IssuesCell: UITableViewCell {
	
	@IBOutlet weak var stateIcon: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var numberLabel: UILabel!
	@IBOutlet weak var openedLabel: UILabel!
	
	/*
	PLEASE NOTE:
	
	Although we'd typically use a horizontal UIStackView to manage dynamic labels,
	I encountered unexpected rendering glitches when scrolling that I felt weren't acceptable.
	
	I then faced a choice between programatically creating labels or working with statically
	defined labels in Interface Builder. For demo purposes, and to keep things consistent
	throughout this demo project, I opted to work with static IB template objects.
	
	This wouldn't be a desirable production solution, and would require matching business rule
	decisions about numbers of labels to show, etc.
	*/
	
	@IBOutlet weak var label_0: UILabel!
	@IBOutlet weak var label_1: UILabel!
	@IBOutlet weak var label_2: UILabel!
	@IBOutlet weak var label_3: UILabel!
	@IBOutlet weak var label_4: UILabel!
}
