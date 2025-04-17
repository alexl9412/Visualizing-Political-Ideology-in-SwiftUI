//
//  Extensions.swift
//  VisualizingPoliticalIdeologyInSwiftUI
//
//  Created by Alex Lenkei on 4/17/25.
//

import Foundation

extension Sequence where Element: BinaryFloatingPoint {
	func average() -> Element {
		var i: Element = 0
		var total: Element = 0

		for value in self {
			total = total + value
			i += 1
		}

		return total / i
	}
}

extension Array where Element == Double {
	mutating func findMedian() -> Double {
		self.sort()
		let size = self.count
		
		if (size % 2 != 0) {
			return self[size/2]
		} else {
			return (self[(size - 1) / 2] + self[size / 2]) / 2
		}
	}
}
