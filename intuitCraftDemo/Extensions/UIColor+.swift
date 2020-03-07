//
//  UIColor+.swift
//  intuitCraftDemo
//
//  Created by Brian Schick on 3/7/20.
//  Copyright © 2020 Brian Schick. All rights reserved.
//

import UIKit

extension UIColor {
	public convenience init?(hexString: String) {
		let r: CGFloat
		let g: CGFloat
		let b: CGFloat
		let a: CGFloat
		
		var hexColor = hexString
		
		// remove # prefix if present
		if hexColor.hasPrefix("#") {
			hexColor = String(hexColor.dropFirst())
		}
		
		// set alpha to opaque if not included
		if hexColor.count == 6 {
			hexColor.append("ff")
		}
		
		// ensure we have an 8 character string
		guard hexColor.count == 8 else { return nil }
		
		// create and return UIColor
		let scanner = Scanner(string: hexColor)
		var hexNumber: UInt64 = 0
		if scanner.scanHexInt64(&hexNumber) {
			r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
			g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
			b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
			a = CGFloat(hexNumber & 0x000000ff) / 255
			
			self.init(red: r, green: g, blue: b, alpha: a)
			return
		}
		
		return nil
	}
	
	public static var githubFallbackColor: UIColor {
		return UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
	}
}
